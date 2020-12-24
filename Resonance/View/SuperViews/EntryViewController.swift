//
//  EntryViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/19/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class EntryViewController: UIViewController{
    
    let entryView = EntryView()
    
    let addLabel = UILabel()
    let gestureArea = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.8309999704, blue: 0.5609999895, alpha: 1)
        
        gestureArea.backgroundColor = .red
        
        loadEntryView()
        //loadAddLabel()
        //loadAddSwipe()
    }
    
    @objc func gestureFired(_ gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            
        }
        else if gesture.state == .changed{
            let translation = gesture.translation(in: self.view)
            if(translation.y > 0){
                entryView.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            if(translation.y >= 250){
                print("new entry")
                let calendarViewController = CalendarViewController()
                self.present(calendarViewController, animated: true)
                gesture.state = .ended
            }
        }
        else if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                self.view.transform = .identity
            })
        }
    }
    
    func loadAddSwipe(){
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        
        gestureArea.addGestureRecognizer(recognizer)
        gestureArea.isUserInteractionEnabled = true
        
        view.addSubview(gestureArea)
        setGestureAreaConstraints()
    }
    
    func loadEntryView(){
        addChild(entryView)
        view.addSubview(entryView.view)
        entryView.didMove(toParent: self)
        setEntryViewConstraints()
    }
    
    func loadAddLabel(){
        addLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        addLabel.text = "Swipe Up to Complete Entry"
        addLabel.textColor = .white
        addLabel.textAlignment = .center
        view.addSubview(addLabel)

        addLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .zero)
    }
    
    func setGestureAreaConstraints(){
        gestureArea.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.frame.width, height: 100))
    }
    
    func setEntryViewConstraints(){
        entryView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.bounds.width, height: 200))
    }
}
