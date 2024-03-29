//
//  EntryViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/16/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class NewEntryViewController: UIViewController, UITextFieldDelegate{
    
    private let addTitleButton = UIButton()
    private let addTitleLabel = UILabel()
    
    private(set) var titleText = UITextField()
    
    private let addTagsButton = UIButton()
    private let addTagsLabel = UILabel()
    
    private(set) var textArea = UITextView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let viewFrame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 770)
        self.view.frame = viewFrame
        
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        
        setupAddTitleButton()
        setupAddTitleLabel()
        setupTitleText()
        setupAddTagsButton()
        setupAddTagsLabel()
        setupTextArea()
        //setupToolbar()
        
        self.titleText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        
        let addTitleButtonFrame = CGRect(x: 0.0, y: 0.0, width: (60), height: (60))
        addTitleButton.frame = addTitleButtonFrame
        
        setAddTitleButtonConstraints()
        
        addTitleButton.addTarget(self, action: #selector(self.addTitleButtonPressed), for: .touchUpInside)
    }
    
    @objc func addTitleButtonPressed(sender: UIButton!){
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) { [self] in
            addTitleLabel.isHidden = true
            addTitleButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        } completion: { [self] (finished: Bool) in
            addTitleButton.isHidden = true
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut) {
                DispatchQueue.main.async {
                    titleText.isHidden = false
                }
                titleText.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                titleText.becomeFirstResponder()
            }
        }
    }
        
    func setupTitleText(){
        titleText.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        titleText.layer.borderWidth = 2
        titleText.layer.cornerRadius = 20

        titleText.textAlignment = .center
        titleText.font = .systemFont(ofSize: 24)
        
        let frame = CGRect(x: 0.0, y: 0.0, width: 360.0, height: 52.0)
        titleText.frame = frame
        
        view.addSubview(titleText)
        
        setTitleTextConstraints()
        
        self.titleText.transform = CGAffineTransform(scaleX: 0.001, y: 1)
        titleText.isHidden = true
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissClick(_:)))
        dismissTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(dismissTap)
    }
    
    @objc func dismissClick(_ gesture: UITapGestureRecognizer){
        
        //called from titleText
        if titleText.isEditing{
            titleText.endEditing(true) // dismiss keyboard
            // user clicks away from titleText after entering a title
            if titleText.hasText{
                titleText.layer.borderWidth = 0
            }
        }
        
        // called from textArea
        if textArea.isFirstResponder{
            textArea.endEditing(true)
        }
      
        //user clicks away from titleText without entering a title __NOT IMPLEMENTED__
//        else if(!titleText.hasText){
//            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) { [self] in
//                addTitleLabel.isHidden = false
//                titleText.transform = CGAffineTransform(scaleX: 0.001, y: 1)
//            } completion: { [self] (finished: Bool) in
//                addTitleButton.isHidden = false
//                UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut) {
//                    DispatchQueue.main.async {
//                        titleText.isHidden = true
//                    }
//                    addTitleButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                }
//            }
//        }
    }
    
    func setupAddTagsButton(){
        addTagsButton.backgroundColor = .black
        addTagsButton.layer.cornerRadius = 30
        
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 40)
        let addIcon = UIImage(systemName: "plus", withConfiguration: iconConfig)
        addTagsButton.setImage(addIcon, for: .normal)
        addTagsButton.imageView?.tintColor = .white
        
        let addTagsButtonFrame = CGRect(x: 0.0, y: 0.0, width: (60), height: (60))
        addTagsButton.frame = addTagsButtonFrame
        
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
        let textAreaFrame = CGRect(x: 0.0, y: 0.0, width: (view.bounds.width/1.15), height: (480))
        textArea.frame = textAreaFrame
        
        setTextAreaConstraints()
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(dismissClick(_:)))
        dismissTap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(dismissTap)
    }
    
//    func setupToolbar(){
//        let toolbar: UIToolbar = UIToolbar()
//        let camera = UIBarButtonItem(title: "Camera", style: .plain, target: self, action: #selector(cameraButtonPressed))
//        toolbar.items = [camera]
//        toolbar.sizeToFit()
//        textArea.inputAccessoryView = toolbar
//    }
//
//    @objc func cameraButtonPressed(){
//
//    }
    
    
    //MARK: Constraints
    //width: 414 height: 896
    /// Setting constraints for the addTitleButton
    func setAddTitleButtonConstraints(){
        addTitleButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/11.2), left: 0, bottom: 0, right: 0), size: .init(width: (addTitleButton.frame.width), height: (addTitleButton.frame.height)))
        NSLayoutConstraint.activate([
            addTitleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// Setting constraints for the addTitle label
    func setAddTitleLabelConstraints(){
        addTitleLabel.anchor(top: addTitleButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/112), left: 0, bottom: 0, right: 0), size: .zero)
        NSLayoutConstraint.activate([
            addTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setTitleTextConstraints(){
        titleText.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/11.2), left: 0, bottom: 0, right: 0), size: .init(width: (titleText.frame.width), height: (titleText.frame.height)))
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// Setting constraints for the addTagsButton
    func setAddTagsButtonConstraints(){
        addTagsButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/4.328), left: 0, bottom: 0, right: 0), size: .init(width: (addTagsButton.frame.width), height: (addTagsButton.frame.height)))
        NSLayoutConstraint.activate([
            addTagsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// Setting contraints for the addTags label
    func setAddTagsLabelConstraints(){
        addTagsLabel.anchor(top: addTagsButton.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/112), left: 0, bottom: 0, right: 0), size: .zero)
        NSLayoutConstraint.activate([
            addTagsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// Setting constraints for the text area
    func setTextAreaConstraints(){
        textArea.anchor(top: addTagsLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width/1.15, height: textArea.frame.height))
        NSLayoutConstraint.activate([
            textArea.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

