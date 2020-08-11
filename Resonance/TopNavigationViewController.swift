//
//  TopNavigationViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 8/9/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class TopNavigationViewController: UIViewController{
    
    /// Initializing buttons and UIStack
    //var buttonStack = UIStackView()
    let todayButton = UIButton(type: .system)
    let calendarButton = UIButton(type: .system)
    let archiveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super .viewDidLoad()
        allignButtons()
    }
    
    /// Alligns buttons at the top in a horizontal row, setting constraints as well
    func allignButtons(){
        configureButtons()
        
        todayButton.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .zero, size: .init(width: todayButton.frame.width, height: todayButton.frame.height))

        
        calendarButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: (calendarButton.titleLabel?.frame.width)!, height: (calendarButton.titleLabel?.frame.height)!))
        
        calendarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        archiveButton.anchor(top: view.topAnchor, leading: nil, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .init(width: archiveButton.frame.width, height: archiveButton.frame.height))
    }
    
    /// Configures the properties and actions for the 3 navigation buttons
    func configureButtons(){
        
        todayButton.backgroundColor = .clear
        todayButton.setTitle("Today", for: .normal)
        todayButton.tintColor = .black
        todayButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        todayButton.addTarget(self, action: #selector(self.todayButtonPressed(sender:)),
                              for: .touchUpInside)
        
        calendarButton.backgroundColor = .clear
        calendarButton.setTitle("Calendar", for: .normal)
        calendarButton.tintColor = .black
        calendarButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        calendarButton.addTarget(self, action: #selector(self.calendarButtonPressed(sender:)),
                                 for: .touchUpInside)
                
        archiveButton.backgroundColor = .clear
        archiveButton.setTitle("Archive", for: .normal)
        archiveButton.tintColor = .black
        archiveButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        archiveButton.addTarget(self, action: #selector(self.archiveButtonPressed(sender:)),
                                for: .touchUpInside)
        
        view.addSubview(todayButton)
        view.addSubview(calendarButton)
        view.addSubview(archiveButton)
    }        
    
    @objc func todayButtonPressed(sender: UIButton!){
        
    }
    
    @objc func calendarButtonPressed(sender: UIButton!){
        
    }
    
    @objc func archiveButtonPressed(sender: UIButton!){
        
    }
}
