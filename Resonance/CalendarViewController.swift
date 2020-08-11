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
    
    let calendarDisplay = CalendarDisplay()
    let topNavigation = TopNavigationViewController()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        loadTopNavigation()
        loadCalendarDisplay()
    }
    
    func loadTopNavigation(){
        addChild(topNavigation)
        view.addSubview(topNavigation.view)
        topNavigation.didMove(toParent: self)
        
        setTopNavigationConstraints()
    }
    
    func loadCalendarDisplay(){
        addChild(calendarDisplay)
        view.addSubview(calendarDisplay.view)
        calendarDisplay.didMove(toParent: self)
        setCalendarDisplayConstraints()
    }
    
    func setTopNavigationConstraints(){
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 54, left: 34, bottom: 0, right: -34), size: .init(width: 346, height: 33))
    }
    
    func setCalendarDisplayConstraints(){
        calendarDisplay.anchor(top: topNavigation.view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 411, height: 386))
        
    }
}


