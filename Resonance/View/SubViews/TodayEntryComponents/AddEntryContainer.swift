//
//  AddEntryContainer.swift
//  Resonance
//
//  Created by Zach Terrell on 12/15/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class AddEntryContainer: UIViewController{
    
    let entryContainerView = TodayEntryContainerView()
    let addLabel = UILabel()
    
    let gestureArea = UIView()

    override func viewDidLoad(){
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height/2.15))
        view.frame = frame
        
        gestureArea.backgroundColor = .clear
                        
        loadAddSwipe()
        loadAddLabel()
        loadEntryContainerView()
    }
    
    @objc func gestureFired(_ gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            
        }
        else if gesture.state == .changed{
            let translation = gesture.translation(in: entryContainerView.view)
            if(translation.y > 0){
                entryContainerView.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            if(translation.y >= 250){
                print("new entry")
                let entryViewController:UIViewController = EntryViewController()
                self.present(entryViewController, animated: true)
                gesture.state = .ended
            }
        }
        else if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                self.entryContainerView.view.transform = .identity
            })
        }
    }
    
    func loadAddSwipe(){
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        
        gestureArea.addGestureRecognizer(recognizer)
        gestureArea.isUserInteractionEnabled = true
        
        view.addSubview(gestureArea)
        gestureArea.layer.cornerRadius = 20
        setGestureAreaConstraints()
    }
    
    func loadEntryContainerView(){
        addChild(entryContainerView)
        view.addSubview(entryContainerView.view)
        entryContainerView.didMove(toParent: self)
        
        entryContainerView.view.layer.cornerRadius = 20
        
        setEntryViewConstraints()
    }
    
    func loadAddLabel(){
        addLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        addLabel.text = "Swipe Down to Add New Entry"        
        addLabel.textColor = .white
        addLabel.textAlignment = .center
        view.addSubview(addLabel)
                
        addLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: (view.frame.height / 22), left: 0, bottom: 0, right: 0), size: .zero)
    }
    
    func setGestureAreaConstraints(){
        gestureArea.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 55))
    }
    
    func setEntryViewConstraints(){
        entryContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.frame.width, height: (view.frame.height * 0.87)))
    }
    
}
