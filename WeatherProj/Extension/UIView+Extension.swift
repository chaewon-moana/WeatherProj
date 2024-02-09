//
//  UIView+Extension.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit
import SnapKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
}
