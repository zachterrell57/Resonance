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

extension UIViewController{
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            view.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            view.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            view.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing{
            view.trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0{
            view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0{
            view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}



