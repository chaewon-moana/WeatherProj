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
        apiManager.callRequestDaily()
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
        forecastTableView.register(HourTableViewCell.self, forCellReuseIdentifier: "HourTableViewCell")
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourTableViewCell", for: indexPath) as! HourTableViewCell
        
        cell.backgroundColor = .blue
        return cell
    }
    
    
}
