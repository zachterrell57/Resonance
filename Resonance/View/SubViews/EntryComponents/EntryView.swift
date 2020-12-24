//
//  EntryViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/16/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class EntryView: UIViewController{
    
    private let addTitleButton = UIButton()
    private let addTitleLabel = UILabel()
    
    private let addTagsButton = UIButton()
    private let addTagsLabel = UILabel()
    
    private let textArea = UITextView()
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        
        let addTitleButtonFrame = CGRect(x: 0.0, y: 0.0, width: (view.bounds.width/6.9), height: 60.0)
        let addTagsButtonFrame = CGRect(x: 0.0, y: 0.0, width: (view.bounds.width/6.9), height: 60.0)
        let textAreaFrame = CGRect(x: 0.0, y: 0.0, width: (view.bounds.width/1.15), height: 480.0)
        
        addTitleButton.frame = addTitleButtonFrame
        addTagsButton.frame = addTagsButtonFrame
        textArea.frame = textAreaFrame
        //textArea.becomeFirstResponder() //brings up keyboard immediately
        
        setupAddTitleButton()
        setupAddTitleLabel()
        setupAddTagsButton()
        setupAddTagsLabel()
        setupTextArea()
    }
    
    
    //MARK: Button Setup
    
    func setupAddTitleButton(){
        addTitleButton.backgroundColor = .black
        addTitleButton.layer.cornerRadius = 30
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 40)
        let addIcon = UIImage(systemName: "plus", withConfiguration: iconConfig)
        addTitleButton.setImage(addIcon, for: .normal)
        addTitleButton.imageView?.tintColor = .white
        
        addTitleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addTitleButton)
        
        setAddTitleButtonConstraints()
    }
    
    func setupAddTagsButton(){
        addTagsButton.backgroundColor = .black
        addTagsButton.layer.cornerRadius = 30
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 40)
        let addIcon = UIImage(systemName: "plus", withConfiguration: iconConfig)
        addTagsButton.setImage(addIcon, for: .normal)
        addTagsButton.imageView?.tintColor = .white
        
        addTitleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addTagsButton)
        
        setAddTagsButtonConstraints()
    }
    
    
    //MARK: Label Setup
    
    func setupAddTitleLabel(){
        
        addTitleLabel.text = "Add Title"
        
        addTitleLabel.font = UIFont.systemFont(ofSize: 14)
        addTitleLabel.textColor = .black
        
        addTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addTitleLabel)
        
        setAddTitleLabelConstraints()                    
    }
    
    func setupAddTagsLabel(){
        
        addTagsLabel.text = "Add Tags"
        
        addTagsLabel.font = UIFont.systemFont(ofSize: 14)
        addTagsLabel.textColor = .black
        
        addTagsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addTagsLabel)
        
        setAddTagsLabelConstraints()
    }
    
    
    //MARK: TextField Setup
    
    func setupTextArea(){
        textArea.layer.cornerRadius = 20
        textArea.layer.borderWidth = 2
        textArea.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        
        addTitleButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textArea)
        setTextAreaConstraints()
    }
    
    
    //MARK: Constraints
    //width: 414 height: 896
    /// Setting constraints for the addTitleButton
    func setAddTitleButtonConstraints(){
        addTitleButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/11.2), left: 0, bottom: 0, right: 0), size: .init(width: (view.bounds.width/6.9), height: (view.bounds.width/6.9)))
        NSLayoutConstraint.activate([
                addTitleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    /// Setting constraints for the addTagsButton
    func setAddTagsButtonConstraints(){
        addTagsButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.width/2.07), left: 0, bottom: 0, right: 0), size: .init(width: (view.bounds.width/6.9), height: (view.bounds.width/6.9)))
        NSLayoutConstraint.activate([
                addTagsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    /// Setting constraints for the text area
    func setTextAreaConstraints(){
        textArea.anchor(top: addTagsLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 360.0, height: 480.0))
        NSLayoutConstraint.activate([
                textArea.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    /// Setting constraints for the addTitle label
    func setAddTitleLabelConstraints(){
        addTitleLabel.anchor(top: addTitleButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/112), left: 0, bottom: 0, right: 0), size: .zero)
        NSLayoutConstraint.activate([
                addTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    /// Setting contraints for the addTags label
    func setAddTagsLabelConstraints(){
        addTagsLabel.anchor(top: addTagsButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/112), left: 0, bottom: 0, right: 0), size: .zero)
        NSLayoutConstraint.activate([
                addTagsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}