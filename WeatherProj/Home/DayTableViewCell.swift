//
//  DayTableViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit
import SnapKit

final class DayTableViewCell: BaseTableViewCell {

    let dayLabel = UILabel()
    let dayWeatherImageView = UIImageView()
    let minTempLabel = UILabel()
    let maxTempLabel = UILabel()
    
    override func setAddView() {
        contentView.addSubviews([dayLabel, dayWeatherImageView, minTempLabel, maxTempLabel])
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        dayWeatherImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(dayLabel.snp.trailing).offset(20)
            make.size.equalTo(30)
        }
        
        minTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(dayWeatherImageView.snp.trailing).offset(12)
        }
        
        maxTempLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(minTempLabel.snp.trailing).offset(8)
        }
    }
    
    override func configureAttribute() {
        
    }

    override func subViewDidLoad() {
        
    }
}
