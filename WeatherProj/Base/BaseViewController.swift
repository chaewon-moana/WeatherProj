//
//  BaseViewController.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddView()
        configureAttribute()
        configureLayout()
        subViewDidLoad()

    }
    

    func setAddView() {
        
    }
    
    func configureAttribute() {
        
    }
    
    func configureLayout() {
        
    }
    
    //자식뷰컨에서 원래 viewdidload에 써야할 부분들 넣는 메소드
    func subViewDidLoad() {
        
    }

}
