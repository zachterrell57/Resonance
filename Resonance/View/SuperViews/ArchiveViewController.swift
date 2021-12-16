//
//  Archive.swift
//  Resonance
//
//  Created by Zach Terrell on 12/16/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class ArchiveViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    var ref: DatabaseReference!
    
    let user = Auth.auth().currentUser
    
    var allEntries = [Entry]()
    
    let topNavigation = TopNavigation()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //margins on collectionview
        layout.sectionInset = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCellSmall.self, forCellWithReuseIdentifier: CustomCellSmall.identifier)
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.loadTopNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieveData()
    }
    
    func loadTopNavigation(){
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
        
        setTopNavigationConstraints()
    }
    
    func retrieveData(){
        let user = FirebaseAuth.Auth.auth().currentUser
        if(!(FirebaseAuth.Auth.auth().currentUser == nil)){
            let uid = user!.uid
            //reference to user's entries in database
            ref = Database.database().reference().child("users/" + uid + "/entries/")
            
            //opens up observer to path
            self.ref.observe(.value, with: { (snapshot) in
                
                //reset entriesOnDay
                self.allEntries.removeAll()
                //for every entry
                for child in snapshot.children{
                    let entry = child as! DataSnapshot
                    if let entryFields = entry.value as? [String: Any]{
                        let uid =  entry.key
                        let title = entryFields["title"] as? String ?? ""
                        let text = entryFields["text"] as? String ?? ""
                                              
                        //add to entriesOnDay
                        self.allEntries.append(.init(
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allEntries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let entry = allEntries[indexPath.row]
        let reviewEntryViewController = ReviewEntryViewController()
        reviewEntryViewController.titleText.text = entry.title
        reviewEntryViewController.textArea.text = entry.text
        present(reviewEntryViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellSmall.identifier, for: indexPath) as! CustomCellSmall
        let title = allEntries[indexPath.row].title
        let cellText = allEntries[indexPath.row].text
        cell.configure(label: title, text: cellText)
        return cell
    }
    
    func setTopNavigationConstraints(){
        let topPadding = CGFloat(50)
        let leftPadding = CGFloat(34)
        let bottomPadding = CGFloat(0)
        let rightPadding = CGFloat(-34)
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding), size: .init(width: 346, height: 40))
    }
    
    func setCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.anchor(top: topNavigation.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
