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
        calendarDisplay.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}

extension UIViewController{
    func anchor(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor, trailing: NSLayoutXAxisAnchor){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: top).isActive = true
        view.leadingAnchor.constraint(equalTo: leading).isActive = true
        view.bottomAnchor.constraint(equalTo: bottom).isActive = true
        view.trailingAnchor.constraint(equalTo: trailing).isActive = true
    }
}
