//
//  BaseCollectionViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
