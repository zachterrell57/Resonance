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
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        loadCalendarDisplay()
    }
    
    func loadCalendarDisplay(){
        addChild(calendarDisplay)
        view.addSubview(calendarDisplay.view)
        calendarDisplay.didMove(toParent: self)
        setCalendarDisplayConstraints()
    }
    
    func setCalendarDisplayConstraints(){
        calendarDisplay.view.translatesAutoresizingMaskIntoConstraints = false
        calendarDisplay.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        calendarDisplay.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        calendarDisplay.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        calendarDisplay.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
