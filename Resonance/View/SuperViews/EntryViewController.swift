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

class EntryViewController: UIViewController, UIAdaptivePresentationControllerDelegate{
    
    var ref: DatabaseReference!
    var user: String!

    var newEntry: NewEntryViewController!
    
    let addLabel = UILabel()
    let gestureArea = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        user = FirebaseAuth.Auth.auth().currentUser!.uid
        newEntry = NewEntryViewController()
        
        self.view.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.8309999704, blue: 0.5609999895, alpha: 1)
        self.view.layer.cornerRadius = 20
        
        loadEntryView()
        loadAddLabel()
        loadAddSwipe()
    }
    
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            refreshParent()
    }
    
    @objc func gestureFired(_ gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            
        }
        else if gesture.state == .changed{
            let translation = gesture.translation(in: newEntry.view)
            if(translation.y < 0){
                newEntry.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            
            if(translation.y <= -200){
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                    self.view.center.y = -400
                            })
                gesture.state = .ended
                
                //send info to database after animation
                sendToDatabase()
                refreshParent()
                self.dismiss(animated: false, completion: nil)
            }
        }
        else if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseIn, animations:  {
                self.newEntry.view.transform = .identity
            })
        }
    }
    
    func refreshParent(){
        self.beginAppearanceTransition(false, animated: true)
        self.presentingViewController?.beginAppearanceTransition(true, animated: true)
        self.endAppearanceTransition()
        self.presentingViewController?.endAppearanceTransition()
    }
    
    func sendToDatabase(){
        //unique identifier for every entry
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
        let entryUID = dateFormatter.string(from: date)

        //if user doesn't enter title, title becomes current date
        var title: String!
        if ((newEntry.titleText.text) == ""){
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "MMM d, h:mm a"
            title = dateFormatter.string(from: date)
        }
        else{
            title = newEntry.titleText.text
        }
        
        //save entry text
        guard let text = newEntry.textArea.text else {return}
        
        //path to number of entries
        let userPath = self.ref.child("users/" + self.user + "/numberOfEntries")
        //update number of entries
        userPath.setValue(ServerValue.increment(1))
        
        //path to entries
        let entryPath = self.ref.child("users/" + self.user + "/entries/" + entryUID)
        //set value of title and text of entry
        entryPath.setValue(["uid": entryUID, "title": title, "text": text])
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
        addChild(newEntry)
        view.addSubview(newEntry.view)
        newEntry.didMove(toParent: self)
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
        gestureArea.anchor(top: newEntry.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
    }
    
    func setEntryViewConstraints(){
        newEntry.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: newEntry.view.frame.width, height: newEntry.view.frame.height))
    }
}

//extension EntryViewController: UIAdaptivePresentationControllerDelegate{ func presentationControllerDidDismiss(_ presentationController: UIPresentationController){
//    self.beginAppearanceTransition(false, animated: true)
//    self.presentingViewController?.beginAppearanceTransition(true, animated: true)
//    self.endAppearanceTransition()
//    self.presentingViewController?.endAppearanceTransition()
//
//    print("dismissed")
//    }
//}

