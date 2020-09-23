//
//  CustomCellSmall.swift
//  Resonance
//
//  Created by Zach Terrell on 8/18/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class CustomCellSmall: UICollectionViewCell{
    
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
