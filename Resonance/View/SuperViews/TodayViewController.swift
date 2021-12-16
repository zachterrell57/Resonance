//
//  TodayViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/15/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class TodayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser
    
    var allEntries = [Entry]()
    
    var reviewSet = [Entry]()
    
    let topNavigation = TopNavigation()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //margins on collectionview
        layout.sectionInset = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCellLarge.self, forCellWithReuseIdentifier: CustomCellLarge.identifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        self.loadTopNavigation()
        
        if(!(user == nil)){
            ref = Database.database().reference().child("users/" + user!.uid)
        }
        
        self.view.backgroundColor = .white
        DispatchQueue.main.async {
            self.loadReviewSet()
        }
    }
    
    override func viewDidAppear(_ animated: Bool){
        
    }
    
    func loadReviewSet(){
        ref.removeAllObservers()
        ref.observe(.value, with:  { (snapshot) in
            if snapshot.hasChild("/currentReviewSet/"){
                let currentReviewSet = snapshot.childSnapshot(forPath: "currentReviewSet")
                if let reviewSetProperties = currentReviewSet.value as? [String: Any]{
                    
                    //get expiration date from datebase
                    let expiration = reviewSetProperties["expiration"] as? String ?? ""
                     
                    //convert expiration to Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
                    dateFormatter.timeZone = TimeZone.current
                    let expirationAsDate = dateFormatter.date(from: expiration)
                    
                    //check if current time is before expiration
                    if Date() < expirationAsDate!{
                        //load entries
                        self.loadCollectionView()
                    }
                    else{
                        //need a new review set
                        self.getNewReviewSet(snapshot: snapshot)
                    }
                }
                
            }
            else{
                //probably a new user, so needs a new review set
                self.getNewReviewSet(snapshot: snapshot)
            }
        })
    }
    
    func getNewReviewSet(snapshot: DataSnapshot){
        allEntries.removeAll()
        let child = snapshot.childSnapshot(forPath: "entries")
        for child in child.children{
            let entry = child as! DataSnapshot            
            if let entryFields = entry.value as? [String: Any]{
                let uid = entry.key
                let title = entryFields["title"] as? String ?? ""
                let text = entryFields["text"] as? String ?? ""

                self.allEntries.append(.init(
                    uid: uid,
                    title: title,
                    text: text
                ))
            }
        }
        if allEntries.count <= 5{
            for entry in allEntries{
                reviewSet.append(entry)
            }
            setNewExpiration()
        }
        else{
            reviewSet = allEntries[randomPick: 5]
            setNewExpiration()
        }
        loadCollectionView()
    }
    
    func setNewExpiration(){
        let userref = Database.database().reference().child("users/" + user!.uid)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
        userref.child("currentReviewSet").child("expiration")
            .setValue(dateFormatter.string(from: Date().addingTimeInterval(60*5)))
    }
    
    func loadTopNavigation(){
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
        
        setTopNavigationConstraints()
    }
    
    func loadCollectionView(){
        self.view.addSubview(self.collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .white
        self.collectionView.reloadData()
        
        self.setCollectionViewConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellLarge.identifier, for: indexPath) as! CustomCellLarge
        let title = reviewSet[indexPath.row].title
        let createdOn = reviewSet[indexPath.row].uid
        let cellText = reviewSet[indexPath.row].text
        cell.configure(label: title, createdOn: createdOn, text: cellText)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let entry = reviewSet[indexPath.row]
        let reviewEntryViewController = ReviewEntryViewController()
        reviewEntryViewController.titleText.text = entry.title
        reviewEntryViewController.textArea.text = entry.text
        present(reviewEntryViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 14
    }

    
    // MARK: Constraints
    
    ///sets contstraints of top navigation
    func setTopNavigationConstraints(){
        let topPadding = CGFloat(50)
        let leftPadding = CGFloat(34)
        let bottomPadding = CGFloat(0)
        let rightPadding = CGFloat(-34)
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding), size: .init(width: 346, height: 40))
    }
    
    
    func setCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.anchor(top: topNavigation.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}

extension Array{
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
