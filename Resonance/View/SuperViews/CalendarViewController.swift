//
//  MainViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 7/21/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import HorizonCalendar
import FirebaseAuth

class CalendarViewController: UIViewController{
    
    // MARK: Initializers
    
    let calendarDisplay = CalendarDisplay()
    let topNavigation = TopNavigation()
    
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        calendarDisplay.parentVC = self
        
        DispatchQueue.main.async {
            self.loadTopNavigation()
            self.loadCalendarDisplay()
            self.refreshEntries()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user == nil{
            let loginViewController: UIViewController = LoginViewController()
            self.present(loginViewController, animated: true, completion: nil)
            loginViewController.isModalInPresentation = true
        }
    }
    
    //Abstracted so it can be called from Calendar Display
    func refreshEntries(){
        self.loadAddEntryContainer()
    }
    
    // MARK: Load elements
    
    ///loads the top navigation bar into the parent view
    func loadTopNavigation(){
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
        
        setTopNavigationConstraints()
    }
    
    //loads the calendar into the parent view
    func loadCalendarDisplay(){
        addChild(calendarDisplay)
        view.addSubview(calendarDisplay.view)
        calendarDisplay.didMove(toParent: self)
        
        calendarDisplay.view.backgroundColor = .white
        
        setCalendarDisplayConstraints()
    }
    
    func loadAddEntryContainer(){
        //gets fresh entry view every time
        let addEntryContainer = AddEntryContainer()
        
        addChild(addEntryContainer)
        view.addSubview(addEntryContainer.view)
        addEntryContainer.didMove(toParent: self)
        
        addEntryContainer.view.backgroundColor = #colorLiteral(red: 0.2349999994, green: 0.8309999704, blue: 0.5609999895, alpha: 1)
        addEntryContainer.view.layer.cornerRadius = 20
        
        setAddEntryContainerConstraints(addEntryContainer: addEntryContainer)
    }
        
        
    // MARK: Constraints
    
    ///sets contstraints of top navigation
    func setTopNavigationConstraints(){
        let topPadding = CGFloat(50)
        let leftPadding = CGFloat(34)
        let bottomPadding = CGFloat(0)
        let rightPadding = CGFloat(-34)
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding), size: .init(width: 346, height: 33))
    }
    
    ///sets contstraints of calendar
    func setCalendarDisplayConstraints(){
        let height = view.frame.width * 1.08
        let width = view.frame.width
        print(width)
        calendarDisplay.anchor(top: topNavigation.view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: width, height: height))
    }
    
    func setAddEntryContainerConstraints(addEntryContainer: AddEntryContainer){
        addEntryContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.frame.width, height: (view.frame.height/2.15)))        
    }
}
