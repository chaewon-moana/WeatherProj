//
//  DailyForecastCollectionViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit
import SnapKit

final class DailyForecastCollectionViewCell: BaseCollectionViewCell {
    
    let dayLabel = UILabel()
    let dayWeatherImageView = UIImageView()
    let dayTempLabel = UILabel()
    
    override func subViewDidLoad() {
        contentView.backgroundColor = .red
    }
    
    override func setAddView() {
        contentView.addSubviews([dayLabel, dayWeatherImageView, dayTempLabel])
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        dayWeatherImageView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(8)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(80)
        }
        
        dayTempLabel.snp.makeConstraints { make in
            make.top.equalTo(dayWeatherImageView.snp.bottom).offset(8)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
    }
    
    override func configureAttribute() {
        dayLabel.textColor = .white
        
        
    }
    
    
}
