//
//  EntryView.swift
//  Resonance
//
//  Created by Zach Terrell on 9/5/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class TodayEntryContainerView: UIViewController{
    
    let entriesOnDay = EntriesOnDay()
    let entriesOnDayHeader = EntriesOnDayHeader()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadEntriesOnDayHeader()
        loadEntriesOnDay()
    }
    
    func loadEntriesOnDayHeader(){
        addChild(entriesOnDayHeader)
        view.addSubview(entriesOnDayHeader.view)
        entriesOnDayHeader.didMove(toParent: self)
        
        setEntryHeaderConstraints()
    }
    
    func loadEntriesOnDay(){
        addChild(entriesOnDay)
        view.addSubview(entriesOnDay.view)
        entriesOnDay.didMove(toParent: self)
        
        setEntriesOnDayConstraints()
    }
    
    func setEntryHeaderConstraints(){
        entriesOnDayHeader.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 5, left: 24, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 40))
    }
    
    func setEntriesOnDayConstraints(){
        entriesOnDay.anchor(top: entriesOnDayHeader.view.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero, size: .zero)
    }
}
