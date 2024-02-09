//
//  HomeViewController.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {

    let cityNameLabel = UILabel()
    let mainTemperatureLabel = UILabel()
    let weatherLabel = UILabel()
    let subTemperatureLabel = UILabel()
    let forecastTableView = UITableView()
    let underLineView = UIView()
    let mapButton = UIButton()
    let cityListButton = UIButton()
    
    let apiManager = OpenWeatherAPIManager.shared
    
    override func setAddView() {
        view.addSubviews([cityNameLabel, mainTemperatureLabel, weatherLabel, subTemperatureLabel, forecastTableView,underLineView, mapButton, cityListButton])
    }
    
    override func configureLayout() {
        apiManager.callRequest()
    }
    
    override func configureAttribute() {
        
    }
    
    override func subViewDidLoad() {
//        forecastTableView.delegate = self
//        forecastTableView.dataSource = self
        
        
    }

}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
