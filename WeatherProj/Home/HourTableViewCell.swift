//
//  hourTableViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit

class HourTableViewCell: BaseTableViewCell {

    let dayLabel = UILabel()
    let tempLabel = UILabel()
    
    override func setAddView() {
        contentView.addSubviews([dayLabel, tempLabel])
    }
    
    override func configureLayout() {
        
    }
    
    override func configureAttribute() {
        
    }
    
    override func subViewDidLoad() {
        
        
    }
}
