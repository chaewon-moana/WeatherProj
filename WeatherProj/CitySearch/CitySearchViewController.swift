//
//  CitySearchViewController.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit

final class CitySearchViewController: BaseViewController {

    let citySearchView = CitySearchView()
    var cityList: [CityList] = []
    override func loadView() {
        super.view = citySearchView
    }
    
    override func subViewDidLoad() {
        guard let path = Bundle.main.path(forResource: "CityList", ofType: "json") else {
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data,
           let city = try? decoder.decode([CityList].self, from: data) {
            cityList = city
        }
        
        citySearchView.tableView.delegate = self
        citySearchView.tableView.dataSource = self
        citySearchView.tableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: "CitySearchTableViewCell")
    }
}

extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitySearchTableViewCell", for: indexPath) as! CitySearchTableViewCell
        
        cell.titleLabel.text = cityList[indexPath.row].name
        cell.titleLabel.textColor = .blue
        cell.subLabel.text = cityList[indexPath.row].country
        cell.subLabel.textColor = .green
        return cell
    }
    
    
}
