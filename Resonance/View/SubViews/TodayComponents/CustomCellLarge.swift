//
//  CustomCellLarge.swift
//  Resonance
//
//  Created by Zach Terrell on 12/15/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class CustomCellLarge: UICollectionViewCell{
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(){
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
    }
    
    func setupSubViews(){
//        addSubview(titleLabel)
//        setTitleLabelConstraints()
    }
    
    func setTitleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil)
    }
}

