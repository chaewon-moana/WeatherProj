//
//  CitySearchTableViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit
import SnapKit

class CitySearchTableViewCell: BaseTableViewCell {
    
    let numberSignImageView = UIImageView()
    let titleLabel = UILabel()
    let subLabel = UILabel()
    
    override func setAddView() {
        contentView.addSubviews([titleLabel, subLabel, numberSignImageView])
    }
    
    override func configureLayout() {
        
        numberSignImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.size.equalTo(20)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(numberSignImageView.snp.trailing).offset(4)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(numberSignImageView.snp.trailing).offset(4)
        }
    }
    
    override func configureAttribute() {
        numberSignImageView.image = UIImage(systemName: "number")
        titleLabel.font = .systemFont(ofSize: 14)
        subLabel.font = .systemFont(ofSize: 12)
    }

}
