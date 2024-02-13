//
//  HomeViewController.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit
import SnapKit
import Kingfisher

enum Week: String, CaseIterable {
    case today = "오늘"
    case secondDay
    case thirdDay
    case forthDay
    case fifthDay
}

final class HomeViewController: BaseViewController {

    let cityNameLabel = WeatherLabel()
    let mainTemperatureLabel = WeatherLabel()
    let weatherImageView = UIImageView()
    let weatherLabel = WeatherLabel()
    let subTemperatureLabel = WeatherLabel()
    let forecastTableView = UITableView()
    let forecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let underLineView = UIView()
    let mapButton = UIButton()
    let cityListButton = UIButton()
    
    let apiManager = OpenWeatherAPIManager.shared
    var weatherList: WeatherModel?
    var dailyWeatherList = WeatherDaily(message: 0, cnt: 0, list: [], city: City(id: 0, name: "", country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
    
    var weekArray: [String] = []
    var tmpList: [DayWeatherInfo] = []
    
    
    override func setAddView() {
        view.addSubviews([cityNameLabel, mainTemperatureLabel, weatherLabel, subTemperatureLabel, forecastTableView,underLineView, mapButton, cityListButton, weatherImageView, forecastCollectionView])
        
        forecastCollectionView.backgroundColor = .yellow
    }
    
    private func hourFormatter(_ date: String) -> String {
        //TODO: Date()로 현재 date받아와서 오늘, 내일 표시할 수 있도록 해보기
        //let dateStr = date //"2024-02-13 18:00:00",

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // 2020-08-13 16:30
                
        let convertDate = dateFormatter.date(from: date)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "hh시"
        
        return myDateFormatter.string(from: convertDate!)
    }
    
    private func setWeek(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let convertDate = dateFormatter.date(from: date)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        myDateFormatter.locale = Locale(identifier:"ko_KR")
       
        return myDateFormatter.string(from: convertDate!)
    }
    
    private func setWeekDay(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertDate = dateFormatter.date(from: date)
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "E"
        myDateFormatter.locale = Locale(identifier:"ko_KR")
       
        return myDateFormatter.string(from: convertDate!)
    }
    override func configureLayout() {
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(20)
        }
        
        mainTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(80)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(mainTemperatureLabel.snp.bottom)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        subTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        forecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subTemperatureLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(200)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(forecastCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.bottom.equalTo(underLineView.snp.top)
        }
        
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(forecastTableView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.snp.bottom).offset(12)
            make.height.equalTo(1)
        }
    }
    
    override func configureAttribute() {
        mainTemperatureLabel.font = .boldSystemFont(ofSize: 30)
        
        weatherImageView.contentMode = .scaleAspectFit
        
        underLineView.layer.borderColor = UIColor.gray.cgColor
        underLineView.layer.borderWidth = 1
    }
    
    private func set5Day(_ weather: WeatherDaily) {
        for idx in weather.list {
            if !weekArray.contains(setWeek(idx.dtTxt)) {
                weekArray.append(setWeek(idx.dtTxt))
                
                tmpList.append(DayWeatherInfo(minTemp: idx.main.tempMin, maxTemp: idx.main.tempMax, weekDay: setWeekDay(setWeek(idx.dtTxt)), weatherIcon: idx.weather[0].icon))
            } else {
                if tmpList[tmpList.count-1].minTemp > idx.main.tempMin {
                    tmpList[tmpList.count-1].minTemp = idx.main.tempMin
                }
                if tmpList[tmpList.count-1].maxTemp < idx.main.tempMax {
                    tmpList[tmpList.count-1].maxTemp = idx.main.tempMax
                }
                
                if tmpList[tmpList.count-1].weatherIcon < idx.weather[0].icon {
                    tmpList[tmpList.count-1].weatherIcon = idx.weather[0].icon
                }
            }
        }
        forecastTableView.reloadData()
    }
    
    override func subViewDidLoad() {
        
        let group = DispatchGroup()
        
        group.enter()
        apiManager.callRequestDaily { model in
            self.dailyWeatherList = model
            self.set5Day(model)
            group.leave()
        }
       
        
        group.enter()
        apiManager.callRequest { model in
            //TODO: weather[0] 해놓은거 처리
            self.weatherList = model
            self.cityNameLabel.text = model.name
            self.mainTemperatureLabel.text = model.main.calTemp
            let url = URL(string: "https://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png")
            self.weatherImageView.kf.setImage(with: url)
            self.weatherLabel.text = model.weather[0].description
            self.subTemperatureLabel.text = "최저 : \(round(model.main.temp_min))°  최고 : \(round(model.main.temp_max))°"
            group.leave()
        }
        
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        
        forecastCollectionView.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: "DailyForecastCollectionViewCell")
        forecastTableView.register(DayTableViewCell.self, forCellReuseIdentifier: "DayTableViewCell")
        
        group.notify(queue: .main) {
            self.forecastTableView.reloadData()
            self.forecastCollectionView.reloadData()
            print(self.dailyWeatherList.list.count)
            print("돼앴따")
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 4
        let cellWidth = UIScreen.main.bounds.width - spacing
        layout.itemSize = CGSize(width: cellWidth / 5, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecastCell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
        
        forecastCell.backgroundColor = .blue
        let item = tmpList[indexPath.item]
        forecastCell.dayLabel.text = item.weekDay
        forecastCell.minTempLabel.text = "최저 : \(item.minTemp)°"
        forecastCell.maxTempLabel.text = "최고 : \(item.maxTemp)°"
        let url = URL(string: "https://openweathermap.org/img/wn/\(item.weatherIcon)@2x.png")
        forecastCell.dayWeatherImageView.kf.setImage(with: url)
        
        return forecastCell
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dailyWeatherList.list.count)
        return dailyWeatherList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyForecastCollectionViewCell", for: indexPath) as! DailyForecastCollectionViewCell
        
        cell.dayLabel.text = hourFormatter(dailyWeatherList.list[indexPath.item].dtTxt)
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(dailyWeatherList.list[indexPath.item].weather[0].icon)@2x.png")
        cell.dayWeatherImageView.kf.setImage(with: url)
        cell.dayTempLabel.text = "\(round((dailyWeatherList.list[indexPath.item].main.temp)))°"
        cell.backgroundColor = .blue
        
        return cell
    }
 
    

    
}
