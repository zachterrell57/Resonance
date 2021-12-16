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
    
    static let identifier = "CustomCellLarge"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let cellText: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 60.0)
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
    
    let cellHeader: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupSubViews()
    }
    
    public func configure(label: String?, createdOn: String?, text: String?){
        titleLabel.text = label
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
        dateFormatter.timeZone = TimeZone.current
        let createdOnAsDate = dateFormatter.date(from: createdOn!)
        dateFormatter.dateFormat = "MMM d, yyyy"
        let shortDate = dateFormatter.string(from: createdOnAsDate!)
        cellHeader.text = "From \(shortDate)"
        
        cellText.text = text
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
        addSubview(cellHeader)
        addSubview(titleLabel)
        addSubview(cellText)
        setTitleLabelConstraints()
        setCellTextConstraints()
        setCellHeaderConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        cellText.text = nil
        cellHeader.text = nil
    }

    
    func setCellHeaderConstraints(){
        cellHeader.translatesAutoresizingMaskIntoConstraints = false
        cellHeader.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0))
    }
    
    func setTitleLabelConstraints(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 100, left: 0, bottom: 0, right: 0))
    }
    
    func setCellTextConstraints(){
        cellText.translatesAutoresizingMaskIntoConstraints = false
        cellText.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 280, height: cellText.frame.height))
        NSLayoutConstraint.activate([
            cellText.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

