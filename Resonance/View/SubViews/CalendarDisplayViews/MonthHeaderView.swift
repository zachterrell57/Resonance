////
////  MonthHeaderView.swift
////  Resonance
////
////  Created by Zach Terrell on 9/27/20.
////  Copyright © 2020 Zach Terrell. All rights reserved.
////
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
    label.backgroundColor = .white
    label.textAlignment = .center
    label.clipsToBounds = true
    
    label.isAccessibilityElement = true
    label.accessibilityTraits = [.header]    
    
    return label
  }

  static func setViewModel(_ viewModel: ViewModel, on view: UILabel) {
    view.text = "\(viewModel.month)"    
  }

}
