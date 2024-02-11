//
//  weatherTextLabel.swift
//  WeatherProj
//
//  Created by cho on 2/11/24.
//

import UIKit

class WeatherLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        textColor = .white
        font = .systemFont(ofSize: 17)
    }
}
