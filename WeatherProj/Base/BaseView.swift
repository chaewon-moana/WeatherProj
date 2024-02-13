//
//  BaseView.swift
//  WeatherProj
//
//  Created by cho on 2/13/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    func setAddView() { }
    
    func configureAttribute() { }
    
    func configureLayout() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
