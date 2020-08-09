//
//  Extensions.swift
//  Resonance
//
//  Created by Zach Terrell on 8/8/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import Foundation
import UIKit
import HorizonCalendar

extension UIColor{
    static let whiteBackgroundColor: UIColor = UIColor(named: "whiteBackgroundColor")!
}

extension Calendar {
    
    func firstDate(of month: Month) -> Date {
        let firstDateComponents = DateComponents(era: month.era, year: month.year, month: month.month)
        guard let firstDate = date(from: firstDateComponents) else {
            preconditionFailure("Failed to create a `Date` representing the first day of \(month).")
        }
        
        return firstDate
    }
}
