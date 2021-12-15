//
//  Entry.swift
//  Resonance
//
//  Created by Zach Terrell on 12/12/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation

class Entry {
    var uid: String?
    var title: String?
    var text: String?
    
    init(uid: String?, title: String?, text: String?){
        self.uid = uid
        self.title = title
        self.text = text
    }
}
