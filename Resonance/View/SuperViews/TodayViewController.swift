//
//  TodayViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 12/15/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class TodayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser
    
    var reviewSet = [Entry]()
    
    let topNavigation = TopNavigation()
    
    let cellID: String = "cellId"
    let headerID: String = "headerID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //margins on collectionview
        layout.sectionInset = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCellLarge.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    override func viewDidLoad() {
        print(user)
        if(!(user == nil)){
            //user = FirebaseAuth.Auth.auth().currentUser
            ref = Database.database().reference().child("users/" + user!.uid + "/")
        }
        
        self.view.backgroundColor = .white
        
        self.loadTopNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool){
        loadReviewSet()
    }
    
    func loadReviewSet(){
        print("in load Review set")
        ref.observe(.value, with:  { (snapshot) in
            print("in observe")
            if snapshot.hasChild("currentReviewSet"){
                for child in snapshot.children{
                    let currentReviewSet = child as! DataSnapshot
                    if let reviewSetProperties = currentReviewSet.value as? [String: Any]{
                        let numberOfEntries = reviewSetProperties["numberOfEntries"] as? Int ?? 0
                        if numberOfEntries < 5{
                            print("Less than 5")
                        }
                    }
                }
            }
            else{
               // getNewReviewSet()
            }
        })
    }
    
    func getNewReviewSet(){
        //reference to user's entries in database
        let databaseRef = ref.child("entries/")
            //opens up observer to path
            self.ref.observe(.value, with: { (snapshot) in
                //for every entry
                for child in snapshot.children{
                    let entry = child as! DataSnapshot
                    if let entryFields = entry.value as? [String: Any]{
                        let uid =  entry.key
                        let title = entryFields["title"] as? String ?? ""
                        let text = entryFields["text"] as? String ?? ""
                        
                        //save current date as Date type
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss:mm"
                        dateFormatter.timeZone = TimeZone.current
                        let uidAsDate = dateFormatter.date(from: uid)
                        
                        self.reviewSet.append(.init(
                            uid: uid,
                            title: title,
                            text: text
                        ))
                    }
                }
                
                self.view.addSubview(self.collectionView)
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.backgroundColor = .white
                self.collectionView.reloadData()
                
                self.setCollectionViewConstraints()
            })
        }
    
    func loadTopNavigation(){
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
        
        setTopNavigationConstraints()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCellLarge
        return cell
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
