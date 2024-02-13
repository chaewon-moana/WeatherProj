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

    let cityNameLabel = WeatherLabel()
    let mainTemperatureLabel = WeatherLabel()
    let weatherImageView = UIImageView()
    let weatherLabel = WeatherLabel()
    let subTemperatureLabel = WeatherLabel()
    let forecastTableView = UITableView()
    let underLineView = UIView()
    let mapButton = UIButton()
    let cityListButton = UIButton()
    
    let apiManager = OpenWeatherAPIManager.shared
    var weatherList: WeatherModel?
    var dailyWeatherList = WeatherDaily(message: 0, cnt: 0, list: [], city: City(id: 0, name: "", country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
    override func setAddView() {
        view.addSubviews([cityNameLabel, mainTemperatureLabel, weatherLabel, subTemperatureLabel, forecastTableView,underLineView, mapButton, cityListButton, weatherImageView])
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
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(subTemperatureLabel.snp.bottom).offset(8)
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
    
    override func subViewDidLoad() {
        apiManager.callRequestDaily { model in
            self.dailyWeatherList = model
            self.forecastTableView.reloadData()
        }
        
        apiManager.callRequest { model in
            //TODO: weather[0] 해놓은거 처리
            self.weatherList = model
            self.cityNameLabel.text = model.name
            self.mainTemperatureLabel.text = "\(round(model.main.temp - 273.15))"
            let url = URL(string: "https://openweathermap.org/img/wn/\(model.weather[0].icon)@2x.png")
            //let url = URL(string: "https://openweathermap.org/img/wn/13d@2x.png")
            self.weatherImageView.kf.setImage(with: url)
            self.weatherLabel.text = model.weather[0].description
            self.subTemperatureLabel.text = "최고 : \(round(model.main.temp_max - 273.15))  최저 : \(round(model.main.temp_min - 273.15))"
        }
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        
        //forecastTableView.register(DayTableViewCell.self, forCellReuseIdentifier: "DayTableViewCell")
        forecastTableView.register(HourTableViewCell.self, forCellReuseIdentifier: "HourTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
        
        if indexPath.row == 0 {
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(DailyForecastCollectionViewCell.self, forCellWithReuseIdentifier: "DailyForecastCollectionViewCell")
            
            return cell
        } else {
            //let forecastCell = tableView.dequeueReusableCell(withIdentifier: "DayTableViewCell", for: indexPath) as! DayTableViewCell
            
            cell.backgroundColor = .blue
            //cell.dayLabel.text = "테스트트세트트"
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row, indexPath.section)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeatherList.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyForecastCollectionViewCell", for: indexPath) as! DailyForecastCollectionViewCell
        
        cell.dayLabel.text = hourFormatter(dailyWeatherList.list[indexPath.item].dtTxt)
        
        let url = URL(string: "https://openweathermap.org/img/wn/\(dailyWeatherList.list[indexPath.item].weather[0].icon)@2x.png")
        cell.dayWeatherImageView.kf.setImage(with: url)
        cell.dayTempLabel.text = "\(round((dailyWeatherList.list[indexPath.item].main.temp) - 273.15))"
        cell.backgroundColor = .blue
        
        return cell
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
    
}
