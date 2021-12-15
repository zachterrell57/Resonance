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
import FirebaseAuth

class CalendarDisplay: UIViewController {
    private lazy var calendarView = CalendarView(initialContent: makeContent())
    private lazy var calendar = Calendar(identifier: .gregorian)
    private lazy var monthWidth = (view.frame.width - 30)
    private lazy var monthsLayout = MonthsLayout.horizontal(options: HorizontalMonthsLayoutOptions(maximumFullyVisibleMonths: 1, scrollingBehavior: .paginatedScrolling(HorizontalMonthsLayoutOptions.PaginationConfiguration(restingPosition: .atIncrementsOfCalendarWidth, restingAffinity: .atPositionsClosestToTargetOffset))))
    
    private lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    var parentVC: CalendarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.bounds.width - monthWidth)
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        //initially sets selected day to current day
        let todayDate = Date()
        let components = self.calendar.dateComponents([.year, .month, .day], from: todayDate)
        Repository.shared.selectedDate = self.calendar.date(from: components)
        
        
        view.addSubview(calendarView)
        calendarView.backgroundColor = .clear
        
        
        calendarView.daySelectionHandler = { [weak self] day in
              guard let self = self else { return }
            
            //sets selected day to day tapped
            Repository.shared.selectedDate = self.calendar.date(from: day.components)            
            self.calendarView.setContent(self.makeContent())
            
            //refresh entries for selected day
            self.parentVC.refreshEntries()
            
              if UIAccessibility.isVoiceOverRunning, let selectedDate = Repository.shared.selectedDate {
                self.calendarView.layoutIfNeeded()
                let accessibilityElementToFocus = self.calendarView.accessibilityElementForVisibleDate(
                  selectedDate)
                UIAccessibility.post(notification: .screenChanged, argument: accessibilityElementToFocus)
              }
            }
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          calendarView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
          calendarView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
          calendarView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
          calendarView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        setCalendarConstraints(calendarView: calendarView)
    }
    
    /// Creates fully functioning calendar with custom elements
    /// - Returns: Calendar view content representing the full calendar 
    private func makeContent() -> CalendarViewContent {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let startDate = Date()
        let endDate = Date()
        let selectedDate = Repository.shared.selectedDate
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: monthsLayout)
            
            .withVerticalDayMargin(monthWidth * 0.0208)
            .withHorizontalDayMargin(monthWidth * 0.0208)
            
            .withMonthHeaderItemModelProvider{ month in
                let textColor: UIColor
                if #available(iOS 13.0, *) {
                  textColor = .label                  
                } else {
                    textColor = .black
                }
                
                let monthText = dateFormatter.string(from: self.calendar.firstDate(of: month))
               
                return CalendarItemModel<MonthHeaderView>(
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 24, weight: .regular),
                        textColor: textColor,
                        monthWidth: self.monthWidth),
                    viewModel: .init(month: monthText))
            }
            
            .withDayOfWeekItemModelProvider{ month, weekdayIndex in
                let textColor: UIColor
                if #available(iOS 13.0, *) {
                  textColor = .label
                  
                } else {
                    textColor = .black
                }
                
                let dayOfWeekText = dateFormatter.veryShortStandaloneWeekdaySymbols[weekdayIndex]

                return CalendarItemModel<DayOfWeekView>(
                  invariantViewProperties: .init(textColor: textColor),
                  viewModel: .init(dayText: dayOfWeekText, dayAccessibilityText: nil))
            }
            
            .withDayItemModelProvider { [calendar, dayDateFormatter] day in
              var invariantViewProperties = DayView.InvariantViewProperties.baseInteractive

              let date = calendar.date(from: day.components)
                
              if date == selectedDate {
                  invariantViewProperties.backgroundColor = .black
                  invariantViewProperties.textColor = .white
                  invariantViewProperties.cornerRadius = 25.0
              }

              return CalendarItemModel<DayView>(
                invariantViewProperties: invariantViewProperties,
                viewModel: .init(
                  dayText: "\(day.day)",
                  accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
                  accessibilityHint: nil))
            }
            
        
            //basically margins
            .withInterMonthSpacing((view.bounds.width - monthWidth) / 2)
    }
    
    func setCalendarConstraints(calendarView: CalendarView){
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                calendarView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
                calendarView.heightAnchor.constraint(equalToConstant: monthWidth * 1.1),
                calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              ])
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        calendarView.insetsLayoutMarginsFromSafeArea = false
    
    }
}





