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

class CalendarViewController: UIViewController{
    
    // MARK: Initializers
    
    let calendarDisplay = CalendarDisplay()
    let topNavigation = TopNavigation()
    let entryContainerView = EntryContainerView()
    
    //let layout = UICollectionViewLayout().init()
    //let notesFromToday = NotesOnDay()
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        loadTopNavigation()
        loadCalendarDisplay()
        loadEntryContainerView()
        //loadNotesFromToday()
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
        
        calendarDisplay.view.backgroundColor = .blue
        
        setCalendarDisplayConstraints()
    }
    
    func loadEntryContainerView(){
        addChild(entryContainerView)
        view.addSubview(entryContainerView.view)
        entryContainerView.didMove(toParent: self)
        
        entryContainerView.view.layer.cornerRadius = 20
        
        setEntryViewConstraints()
    }
    
    //loads the calendar into the parent view
//    func loadNotesFromToday(){
//        addChild(notesFromToday)
//        view.addSubview(notesFromToday.view)
//        notesFromToday.didMove(toParent: self)
//
//        notesFromToday.collectionView.layer.cornerRadius = 20
//
//        setNotesFromTodayConstraints()
//    }
    
    
    // MARK: Constraints
    
    ///sets contstraints of top navigation
    func setTopNavigationConstraints(){
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 34, bottom: 0, right: -34), size: .init(width: 346, height: 33))
    }
    
    ///sets contstraints of calendar
    func setCalendarDisplayConstraints(){
        calendarDisplay.anchor(top: topNavigation.view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: (view.frame.width - 30), height: ((view.frame.width - 30) * 1.05)))
    }
    
    func setEntryViewConstraints(){
        entryContainerView.anchor(top: calendarDisplay.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    ///sets constraints for notes from today section
//    func setNotesFromTodayConstraints(){
//        notesFromToday.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 414, height: 360))
//    }
}


