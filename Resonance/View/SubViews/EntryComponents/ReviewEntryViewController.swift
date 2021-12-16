//
//  ReviewEntryViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/16/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//
import Foundation
import UIKit
import FirebaseFirestore

class ReviewEntryViewController: UIViewController{
    
    private let addTitleLabel = UILabel()
    
    private(set) var titleText = UITextField()
    
    private let addTagsLabel = UILabel()
    
    private(set) var textArea = UITextView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let viewFrame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 770)
        self.view.frame = viewFrame
        
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        
        setupTitleText()
//        setupAddTagsButton()
//        setupAddTagsLabel()
        setupTextArea()
        //setupToolbar()
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
    }
    
    //MARK: TextField Setup
    
    func setupTextArea(){
        textArea.layer.cornerRadius = 20
        textArea.layer.borderWidth = 2
        textArea.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        
        view.addSubview(textArea)
        let textAreaFrame = CGRect(x: 0.0, y: 0.0, width: (view.bounds.width/1.15), height: (480))
        textArea.frame = textAreaFrame
        
        setTextAreaConstraints()
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
    
    func setTitleTextConstraints(){
        titleText.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: (view.bounds.height/11.2), left: 0, bottom: 0, right: 0), size: .init(width: (titleText.frame.width), height: (titleText.frame.height)))
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    /// Setting constraints for the text area
    func setTextAreaConstraints(){
        textArea.anchor(top: titleText.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width/1.15, height: textArea.frame.height))
        NSLayoutConstraint.activate([
            textArea.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


