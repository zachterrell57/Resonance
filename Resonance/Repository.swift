//
//  Repository.swift
//  Resonance
//
//  Created by Zach Terrell on 12/15/21.
//  Copyright © 2021 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit

class Repository{
    static let shared = Repository()
    
    var selectedDate: Date?
    var currentVC: UIViewController?
}
