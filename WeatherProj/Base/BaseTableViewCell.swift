//
//  BaseTableViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAddView()
        configureAttribute()
        configureLayout()
        subViewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddView() {
        
    }
    
    func configureAttribute() {
        
    }
    
    func configureLayout() {
        
    }
    
    func subViewDidLoad() {
        
    }
    
    
}
