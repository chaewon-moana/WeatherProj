//
//  HomeView.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    let cityNameLabel = WeatherLabel()
    let mainTemperatureLabel = WeatherLabel()
    let weatherImageView = UIImageView()
    let weatherLabel = WeatherLabel()
    let forecastTableView = UITableView()
    let forecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let underLineView = UIView()
    let mapButton = UIButton()
    let cityListButton = UIButton()
    let underView = UIView()
    
    override func setAddView() {
        addSubviews([cityNameLabel, mainTemperatureLabel, weatherLabel, forecastTableView,underLineView, weatherImageView, forecastCollectionView, underView])
        underView.addSubviews([mapButton, cityListButton])
    }
    
    override func configureLayout() {
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.height.equalTo(20)
        }
        
        mainTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(mainTemperatureLabel.snp.bottom)
        }
        
        weatherLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
 
        forecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weatherLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(8)
            make.height.equalTo(200)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(forecastCollectionView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(8)
            make.bottom.equalTo(underLineView.snp.top)
        }
        
        underLineView.snp.makeConstraints { make in
           // make.top.equalTo(forecastTableView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(underView.snp.top)
            make.height.equalTo(1)
        }
        
        underView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(8)
            //make.top.equalTo(forecastTableView.snp.bottom)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        cityListButton.snp.makeConstraints { make in
            make.size.equalTo(80)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    override func configureAttribute() {
        
        cityListButton.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        underView.backgroundColor = .gray
        
        cityListButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        
        mainTemperatureLabel.font = .boldSystemFont(ofSize: 30)
        
        weatherImageView.contentMode = .scaleAspectFit
        
        underLineView.layer.borderColor = UIColor.gray.cgColor
        underLineView.layer.borderWidth = 1
    }
    @objc func touchButton() {
        print("버어튼 눌림")
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
