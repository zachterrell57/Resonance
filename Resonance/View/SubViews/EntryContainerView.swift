//
//  EntryView.swift
//  Resonance
//
//  Created by Zach Terrell on 9/5/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class EntryContainerView: UIViewController{
    
    let entriesOnDay = EntriesOnDay()
    let entryHeader = EntriesOnDayHeader()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .red
        
        loadEntryHeader()
        loadEntriesOnDay()
    }
    
    func loadEntryHeader(){
        addChild(entryHeader)
        view.addSubview(entryHeader.view)
        entryHeader.didMove(toParent: self)
        
        setEntryHeaderConstraints()
    }
    
    func loadEntriesOnDay(){
        addChild(entriesOnDay)
        view.addSubview(entriesOnDay.view)
        entriesOnDay.didMove(toParent: self)
        
        setEntriesOnDayConstraints()
    }
    
    func setEntryHeaderConstraints(){
        entryHeader.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 24, bottom: 0, right: 0), size: .init(width: view.frame.width, height: 40))
    }
    
    func setEntriesOnDayConstraints(){
        entriesOnDay.anchor(top: entryHeader.view.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: view.frame.width, height: 321))
    }
}
