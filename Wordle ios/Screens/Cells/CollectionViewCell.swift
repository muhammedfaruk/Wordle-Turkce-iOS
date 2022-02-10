//
//  CollectionViewCell.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 8.02.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
    
    let label = UILabel()        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    func configure(){
        addSubview(label)
        label.frame = bounds
        let width = bounds.width
        label.font = UIFont.systemFont(ofSize: width)
        label.textAlignment = .center
//        label.text = "A"
        backgroundColor = .clear
    }
}
