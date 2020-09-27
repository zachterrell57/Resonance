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
    private lazy var monthWidth = (view.frame.width - 30)
    private lazy var monthsLayout = MonthsLayout.horizontal(monthWidth: monthWidth)
    
    private var selectedDay: Day?
    
    private lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(calendarView)
        
        setCalendarConstraints(calendarView: calendarView)           
    }
    
    /// Creates fully functioning calendar with custom elements
    /// - Returns: Calendar view content representing the full calendar 
    private func makeContent() -> CalendarViewContent {
        
        let monthHeaderDateFormatter = DateFormatter()
        monthHeaderDateFormatter.calendar = calendar
        monthHeaderDateFormatter.dateFormat = "MMMM yyyy"
        
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 16))!
        let endDate = calendar.date(from: DateComponents(year: 2020, month: 12, day: 05))!
        let selectedDay = self.selectedDay
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: monthsLayout)
            
            .withVerticalDayMargin(4.5)
            .withHorizontalDayMargin(8)
            .withBackgroundColor(.clear)
            
//            .withMonthHeaderItemProvider({ (Month) -> AnyCalendarItem in
//                return CalendarItem<UILabel, String>(
//                    viewModel: monthHeaderDateFormatter.string(from: self.calendar.firstDate(of: Month)),
//                    styleID: "MonthHeaderStyle",
//                    buildView: {
//                        let label = UILabel()
//                        label.textAlignment = .center
//                        label.font = UIFont.systemFont(ofSize: 24)
//                        if #available(iOS 13.0, *) {
//                            label.textColor = .label
//                        } else {
//                            label.textColor = .black
//                        }
//                        label.isAccessibilityElement = true
//                        label.accessibilityTraits = [.header]
//                        label.layoutMargins.top = (self.monthWidth / 20)
//                        label.layoutMargins.bottom = (self.monthWidth / 18)
//
//                        return label
//                    },
//                    updateViewModel: { label, monthText in
//                        label.text = monthText
//                        label.accessibilityLabel = monthText
//                    })
//            })
//
//            .withDayOfWeekItemModelProvider({ (Month, Day) -> AnyCalendarItemModel in
//                CalendarItemModel<String>(
//                    viewModel: monthHeaderDateFormatter.veryShortStandaloneWeekdaySymbols[Day],
//                    styleID: "DefaultDayOfWeekItem",
//                    buildView: {
//                        let label = UILabel()
//                        label.textAlignment = .center
//                        label.font = UIFont.systemFont(ofSize: 18)
//                        label.textColor = .black
//                        label.backgroundColor = .clear
//                        label.isAccessibilityElement = false
//                        return label
//                    },
//                    updateViewModel: { label, dayOfWeekText in
//                        label.text = dayOfWeekText
//                    })
//            })
            
            .withDayOfWeekItemModelProvider{ [weak self] day in
                let textColor: UIColor
                let backgroundColor: UIColor
                if #available(iOS 13.0, *) {
                  textColor = .secondaryLabel
                  backgroundColor = .systemBackground
                } else {
                  textColor = .black
                  backgroundColor = .white
                

                let dayOfWeekText = dateFormatter.veryShortStandaloneWeekdaySymbols[weekdayIndex]

                return CalendarItemModel<DayOfWeekView>(
                    invariantViewProperties: .init(textColor: textColor)
                  viewModel: .init(text: dayOfWeekText, accessibilityLabel: nil))
            }
            
            
            
            .withDayItemModelProvider { [weak self] day in
                let textColor: UIColor
                if #available(iOS 13.0, *) {
                    textColor = .label
                } else {
                    textColor = .black
                }

                let dayAccessibilityText: String?
                if let date = self?.calendar.date(from: day.components) {
                    dayAccessibilityText = self?.dayDateFormatter.string(from: date)
                } else {
                    dayAccessibilityText = nil
                }

                return CalendarItemModel<DayView>(
                    invariantViewProperties: .init(textColor: textColor, isSelectedStyle: day == selectedDay),
                    viewModel: .init(dayText: "\(day.day)", dayAccessibilityText: dayAccessibilityText))
            }
    }
    
    func setCalendarConstraints(calendarView: CalendarView){
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: monthWidth * 1.05),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        calendarView.insetsLayoutMarginsFromSafeArea = false
        
        if case .horizontal(let monthWidth) = monthsLayout {
            let marginSize = (view.bounds.width - monthWidth) / 2
            calendarView.layoutMargins.left = (marginSize)
            calendarView.layoutMargins.right = (marginSize)
            calendarView.layoutMargins.top = (marginSize / 1.6)
            calendarView.layoutMargins.bottom = 0
            
            calendarView.setContent(makeContent().withInterMonthSpacing(marginSize))
            
            
        }
    }
}





