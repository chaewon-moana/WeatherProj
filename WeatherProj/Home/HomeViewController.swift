//
//  HomeViewController.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit
import SnapKit
import Kingfisher

final class HomeViewController: BaseViewController {

    let homeView = HomeView()
    
    let apiManager = OpenWeatherAPIManager.shared
    var dailyWeatherList = WeatherDaily(message: 0, cnt: 0, list: [], city: City(id: 0, name: "", country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
    
    var weatherList = WeatherModel(weather: [], main: Main(temp: 0, feels_like: 0, temp_min: 0, temp_max: 0), id: 0, name: "")
    
    var weekArray: [String] = []
    
    //MARK: 그런데 이러면 날짜가 바뀔 때마다 새로운 공간이 생겨나는 것 아닌가?, 영구적으로 저장되는 것이 아니라 상관없나,,,,?
    var tmpList: [DayWeatherInfo] = []
    
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
    
    override func loadView() {
        self.view = homeView
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
        homeView.forecastTableView.reloadData()
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
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.homeView.forecastTableView.reloadData()
            self.homeView.forecastCollectionView.reloadData()
            self.setCurrentView()
            print(self.dailyWeatherList.list.count)
            print("돼앴따")
        }
        
        homeView.forecastTableView.delegate = self
        homeView.forecastTableView.dataSource = self
        
        homeView.forecastCollectionView.delegate = self
        homeView.forecastCollectionView.dataSource = self
        
        homeView.forecastCollectionView.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: "DailyForecastCollectionViewCell")
        homeView.forecastTableView.register(DayTableViewCell.self, forCellReuseIdentifier: "DayTableViewCell")
        
        homeView.cityListButton.addTarget(self, action: #selector(cityListButtonTapped), for: .touchUpInside)

    }
    
    @objc func cityListButtonTapped() {
        print("눌려땅")
        let vc = CitySearchViewController()
     
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setCurrentView() {
        homeView.cityNameLabel.text = weatherList.name
        homeView.mainTemperatureLabel.text = "\(weatherList.main.calTemp)°"
        let url = URL(string: "https://openweathermap.org/img/wn/\(weatherList.weather[0].icon)@2x.png")
        homeView.weatherImageView.kf.setImage(with: url)
        homeView.weatherLabel.text = weatherList.weather[0].description
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
        forecastCell.dayLabel.text = indexPath.item == 0 ? "오늘" : item.weekDay
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
