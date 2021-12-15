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
        createDayLabel()
    }
    
    func createDayLabel(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        label.font = UIFont.systemFont(ofSize: 24)
        
        label.text = "Notes From \(dateFormatter.string(from: Repository.shared.selectedDate!))"
        
        view.addSubview(label)
        
        label.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero)
    }    
}
