//
//  EntryViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/19/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class EntryViewController: UIViewController{
    
    var ref: DatabaseReference!
    var user: String!

    var entryView: EntryView!
    
    let addLabel = UILabel()
    let gestureArea = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        user = FirebaseAuth.Auth.auth().currentUser!.uid
        entryView = EntryView()
        
        self.view.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.8309999704, blue: 0.5609999895, alpha: 1)
        self.view.layer.cornerRadius = 20
        
        loadEntryView()
        loadAddLabel()
        loadAddSwipe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }
    
    @objc func gestureFired(_ gesture: UIPanGestureRecognizer){
        
        if gesture.state == .began{
            
        }
        else if gesture.state == .changed{
            let translation = gesture.translation(in: entryView.view)
            if(translation.y < 0){
                entryView.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            
            if(translation.y <= -200){
                print("entry added")
                
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                    self.view.center.y = -400
                            })
                gesture.state = .ended
                self.dismiss(animated: false, completion: nil)
            }
        }
        else if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                self.entryView.view.transform = .identity
            })
            
            sendToDatabase()
        }
        
    }
    
    func sendToDatabase(){
        var title: String!
        print("title text:" + entryView.titleText.text!)
        if ((entryView.titleText.text) == ""){
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm a"
            print(dateFormatter.string(from: date))
            title = dateFormatter.string(from: date)
        }
        else{
            title = entryView.titleText.text
        }
        guard let text = entryView.textArea.text else {return}
        let path = self.ref.child("users/" + self.user + "/entries/" + title)

        path.setValue(["text": text])
    }
    
    func loadAddSwipe(){
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        
        gestureArea.addGestureRecognizer(recognizer)
        gestureArea.isUserInteractionEnabled = true
        
        gestureArea.backgroundColor = .clear
        
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

        addLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -50, right: 0), size: .zero)
    }
    
    //MARK: Constraints
    
    func setGestureAreaConstraints(){
        gestureArea.anchor(top: entryView.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
    }
    
    func setEntryViewConstraints(){
        entryView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: entryView.view.frame.width, height: entryView.view.frame.height))
    }
}
