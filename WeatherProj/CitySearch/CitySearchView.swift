//
//  CitySearchView.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit
import SnapKit

class CitySearchView: BaseView {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func setAddView() {
        addSubviews([searchBar, tableView])
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(36)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        
    }
}
