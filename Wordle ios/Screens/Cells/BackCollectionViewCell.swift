//
//  BackCollectionViewCell.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 9.02.2022.
//

import UIKit

class BackCollectionViewCell: UICollectionViewCell {
   
    let label = UILabel()        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    
    func set(color:UIColor?){
        if color == nil {
            backgroundColor = .systemGray3
        }else {
            backgroundColor = color
        }
    }
    
    func configure(){
        addSubview(label)
        label.frame = bounds
        let width = bounds.width
        label.font = UIFont.systemFont(ofSize: width)
        label.textAlignment = .center
    }
}
