//
//  hourTableViewCell.swift
//  WeatherProj
//
//  Created by cho on 2/8/24.
//

import UIKit
import SnapKit

class HourTableViewCell: BaseTableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    override func setAddView() {
        contentView.addSubviews([collectionView])
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        collectionView.backgroundColor = .red
    }
    
    override func subViewDidLoad() {
        
    }
    
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 4
        let cellWidth = UIScreen.main.bounds.width - spacing
       // let cellHeight = 200
        layout.itemSize = CGSize(width: cellWidth / 5, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
