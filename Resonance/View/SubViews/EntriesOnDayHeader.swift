//
//  NotesOnDayHeader.swift
//  Resonance
//
//  Created by Zach Terrell on 9/5/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class EntriesOnDayHeader: UIViewController{
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        //view.backgroundColor = .green
        createDayLabel()
    }
    
    func createDayLabel(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let date = Date()
        
        label.font = UIFont.systemFont(ofSize: 24)
        
        label.text = "Notes from \(dateFormatter.string(from: date))"
        
        view.addSubview(label)
        
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero)
    }    
}
