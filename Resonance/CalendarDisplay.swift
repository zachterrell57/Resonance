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
    
    private lazy var calendarView = CalendarView(initialContent: makeContent())
    private lazy var calendar = Calendar(identifier: .gregorian)
    private lazy var monthWidth = (min(min(view.bounds.width, view.bounds.height) - 64, 512))
    private lazy var monthsLayout = MonthsLayout.horizontal(monthWidth: monthWidth)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
          view.backgroundColor = .systemBackground
        } else {
          view.backgroundColor = .white
        }
        
        view.addSubview(calendarView)
        
        calendarView.insetsLayoutMarginsFromSafeArea = false
        
        setCalendarConstraints(calendarView: calendarView)
    }
    
    /// Creates fully functioning calendar with custom elements
    /// - Returns: Calendar view content representing the full calendar 
    private func makeContent() -> CalendarViewContent {
        
        let monthHeaderDateFormatter = DateFormatter()
        monthHeaderDateFormatter.calendar = calendar
        monthHeaderDateFormatter.dateFormat = "MMMM yyyy"
        
        let startDate = Date()
        let endDate = calendar.date(from: DateComponents(year: 2021, month: 7, day: 31))!
        
        
        return CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: monthsLayout)
            
            //.withInterMonthSpacing(30)
            .withVerticalDayMargin(8)
            .withHorizontalDayMargin(8)
            .withBackgroundColor(.clear)
            
            .withMonthHeaderItemProvider({ (Month) -> AnyCalendarItem in
                return CalendarItem<UILabel, String>(
                    viewModel: monthHeaderDateFormatter.string(from: self.calendar.firstDate(of: Month)),
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
            
            .withDayOfWeekItemProvider({ (Month, Day) -> AnyCalendarItem in
                CalendarItem<UILabel, String>(
                    viewModel: monthHeaderDateFormatter.veryShortStandaloneWeekdaySymbols[Day],
                    styleID: "DefaultDayOfWeekItem",
                    buildView: {
                        let label = UILabel()
                        label.textAlignment = .center
                        label.font = UIFont.systemFont(ofSize: 18)
                        label.textColor = .black
                        label.backgroundColor = .clear
                        label.isAccessibilityElement = false
                        return label
                },
                    updateViewModel: { label, dayOfWeekText in
                        label.text = dayOfWeekText
                })
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
    
    func setCalendarConstraints(calendarView: CalendarView){
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        
        let monthWidth = min(min(view.bounds.width, view.bounds.height) - 64, 512)
        NSLayoutConstraint.activate([
            calendarView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: monthWidth * 1.1),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if case .horizontal(let monthWidth) = monthsLayout {
            let marginSize = (view.bounds.width - monthWidth) / 2
            calendarView.layoutMargins.left = marginSize
            calendarView.layoutMargins.right = marginSize
            
            calendarView.setContent(makeContent().withInterMonthSpacing(marginSize))
        }
    }
}





