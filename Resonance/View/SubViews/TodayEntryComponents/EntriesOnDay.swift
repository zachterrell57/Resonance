//
//  NotesOnDate.swift
//  Resonance
//
//  Created by Zach Terrell on 8/17/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class EntriesOnDay: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var ref: DatabaseReference!
    
    //array storing the entries from today
    var entriesOnDay = [Entry]()
    
    let cellID: String = "cellId"
    let headerID: String = "headerID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //margins on collectionview
        layout.sectionInset = UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(CustomCellSmall.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //reloads data everytime view appears
        retrieveData()
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
                self.entriesOnDay.removeAll()
                                
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
                        
                        //check if current date and note date are equal
                        if Calendar.current.isDate(uidAsDate!, equalTo: Repository.shared.selectedDate!, toGranularity: .day){
                            //add to entriesOnDay
                            self.entriesOnDay.append(.init(
                                uid: uid,
                                title: title,
                                text: text
                            ))
                        }
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
        
    //MARK: Collectionview Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entriesOnDay.count    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCellSmall
        return cell
    }
    
    func setCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
