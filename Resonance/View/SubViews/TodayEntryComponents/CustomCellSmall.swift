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
    
    static let identifier = "CustomCellSmall"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 160, height: 20)
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let cellText: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0.0, y: 0.0, width: 150.0, height: 60.0)
        textView.text = ""
        textView.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textView.textColor = .white
        textView.backgroundColor = .black
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isEditable = false
        return textView
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
        
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    public func configure(label: String?, text: String?){
        titleLabel.text = label
        cellText.text = text
    }
    
    func setupSubViews(){
        addSubview(titleLabel)
        addSubview(cellText)
        setTitleLabelConstraints()
        setCellTextConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        cellText.text = nil
    }
    
    func setTitleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: titleLabel.frame.width, height: titleLabel.frame.height))
    }
    
    func setCellTextConstraints(){
        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellText.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 3, left: 0, bottom: 0, right: 0), size: .init(width: cellText.frame.width, height: cellText.frame.height))
        NSLayoutConstraint.activate([
            cellText.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
