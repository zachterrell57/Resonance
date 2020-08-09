//
//  ViewController.swift
//  Resonance
//
//  Created by Zach Terrell on 7/18/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import UIKit
import HorizonCalendar
import Foundation

class CalendarDisplay: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView = CalendarView(initialContent: makeContent())
        view.addSubview(calendarView)
        view.backgroundColor = .white
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let monthWidth = min(min(view.bounds.width, view.bounds.height) - 64, 512)
        NSLayoutConstraint.activate([
            calendarView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: monthWidth * 1.1),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    
    private func makeContent() -> CalendarViewContent {
        let monthWidth = (min(min(view.bounds.width, view.bounds.height) - 64, 512))
        let monthsLayout: MonthsLayout = .horizontal(monthWidth: monthWidth)
        
        
        let calendar = Calendar(identifier: .gregorian)
        
        let monthHeaderDateFormatter = DateFormatter()
        monthHeaderDateFormatter.calendar = calendar
        monthHeaderDateFormatter.dateFormat = "MMMM yyyy"
        
        let startDate = Date()
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 7, day: 31))!
        
        
        return CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: monthsLayout)
            
            .withInterMonthSpacing(30)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
            .withBackgroundColor(.clear)
            
            .withMonthHeaderItemProvider({ (Month) -> AnyCalendarItem in
                return CalendarItem<UILabel, String>(
                    viewModel: monthHeaderDateFormatter.string(from: calendar.firstDate(of: Month)),
                    styleID: "MonthHeaderStyle",
                    buildView: {
                        let label = UILabel()
                        label.textAlignment = .center
                        label.font = UIFont.systemFont(ofSize: 24)
                        if #available(iOS 13.0, *) {
                            label.textColor = .label
                        } else {
                            label.textColor = .black
                        }
                        label.isAccessibilityElement = true
                        label.accessibilityTraits = [.header]
                        return label
                },
                    updateViewModel: { label, monthText in
                        label.text = monthText
                        label.accessibilityLabel = monthText
                })
            })
            
            .withDayOfWeekItemProvider({ (Month, <#Int#>) -> AnyCalendarItem in
                <#code#>
            })
            
            .withDayItemProvider { day in
                CalendarItem<UILabel, Day>(
                    viewModel: day,
                    styleID: "DayLabelStyle",
                    buildView: {
                        let label = UILabel()
                        label.font = UIFont.systemFont(ofSize: 18)
                        label.textAlignment = .center
                        label.textColor = .black
                        label.clipsToBounds = true
                        label.layer.borderColor = UIColor.clear.cgColor
                        label.layer.borderWidth = 1
                        label.layer.cornerRadius = 22
                        return label
                },
                    updateViewModel: { label, day in
                        label.text = "\(day.day)"
                })
        }
    }
}





