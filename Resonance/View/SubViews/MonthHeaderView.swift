////
////  MonthHeaderView.swift
////  Resonance
////
////  Created by Zach Terrell on 9/27/20.
////  Copyright © 2020 Zach Terrell. All rights reserved.
////
//
//
//import HorizonCalendar
//import UIKit
//
//// MARK: - DayView
//
//final class MonthHeaderView: UIView {
//
//    // MARK: Lifecycle
//
//    init(invariantViewProperties: InvariantViewProperties) {
//        monthLabel = UILabel()
//        monthLabel.font = invariantViewProperties.font
//        monthLabel.textAlignment = invariantViewProperties.textAlignment
//        monthLabel.textColor = invariantViewProperties.textColor
//        monthWidth = invariantViewProperties.monthWidth
//
//        super.init(frame: .zero)
//
//        monthLabel.isAccessibilityElement = true
//        monthLabel.accessibilityTraits = [.header]
//        monthLabel.layoutMargins.top = (self.monthWidth / 20)
//        monthLabel.layoutMargins.bottom = (self.monthWidth / 18)
//
//
//        addSubview(monthLabel)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    // MARK: Internal
//
//    var monthText: String {
//        get { monthLabel.text ?? "" }
//        set { monthLabel.text = newValue }
//    }
//
//    var dayAccessibilityText: String?
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        monthLabel.frame = bounds
//
//        layer.cornerRadius = min(bounds.width, bounds.height) / 2
//    }
//
//    // MARK: Private
//
//    private let monthLabel: UILabel
//    private let monthWidth: CGFloat
//}
//
//// MARK: UIAccessibility
//
//extension MonthHeaderView {
//
//    override var isAccessibilityElement: Bool {
//        get { true }
//        set { }
//    }
//
//    override var accessibilityLabel: String? {
//        get { dayAccessibilityText ?? monthText }
//        set { }
//    }
//
//}
//
//// MARK: CalendarItemViewRepresentable
//
//extension MonthHeaderView: CalendarItemViewRepresentable {
//
//    struct InvariantViewProperties: Hashable {
//        var font = UIFont.systemFont(ofSize: 24 )
//        var textAlignment = NSTextAlignment.center
//        var textColor: UIColor
//        var monthWidth: CGFloat
//    }
//
//    struct ViewModel: Equatable {
//        let monthText: String
//        let dayAccessibilityText: String?
//    }
//
//    static func makeView(
//        withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
//    -> MonthHeaderView
//    {
//        MonthHeaderView(invariantViewProperties: invariantViewProperties)
//    }
//
//    static func setViewModel(_ viewModel: ViewModel, on view: MonthHeaderView) {
//        view.monthText = viewModel.monthText
//        view.dayAccessibilityText = viewModel.dayAccessibilityText
//    }
//
//}
//

import HorizonCalendar

struct MonthHeaderView: CalendarItemViewRepresentable {

  /// Properties that are set once when we initialize the view.
  struct InvariantViewProperties: Hashable {
    let font: UIFont
    let textColor: UIColor
    let monthWidth: CGFloat
  }

  /// Properties that will vary depending on the particular date being displayed.
  struct ViewModel: Equatable {
    let month: String
  }

  static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> UILabel
  {
    let label = UILabel()

    label.font = invariantViewProperties.font
    label.textColor = invariantViewProperties.textColor

    label.textAlignment = .center
    label.clipsToBounds = true
    
    label.isAccessibilityElement = true
    label.accessibilityTraits = [.header]
    label.layoutMargins.top = (invariantViewProperties.monthWidth / 20)
    label.layoutMargins.bottom = (invariantViewProperties.monthWidth / 18)
    
    return label
  }

  static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
    view.text = "\(viewModel.month)"
  }

}
