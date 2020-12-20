//
//  DayOfWeekView.swift
//  Resonance
//
//  Created by Zach Terrell on 9/26/20.
//  Copyright © 2020 Zach Terrell. All rights reserved.
//

import HorizonCalendar
import UIKit

// MARK: - DayView

final class DayOfWeekView: UIView {

  // MARK: Lifecycle

  init(invariantViewProperties: InvariantViewProperties) {
    dayofWeekLabel = UILabel()
    dayofWeekLabel.font = invariantViewProperties.font
    dayofWeekLabel.textAlignment = invariantViewProperties.textAlignment
    dayofWeekLabel.textColor = invariantViewProperties.textColor
    dayofWeekLabel.backgroundColor = .white

    super.init(frame: .zero)
     
    addSubview(dayofWeekLabel)    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  var dayText: String {
    get { dayofWeekLabel.text ?? "" }
    set { dayofWeekLabel.text = newValue }
  }

  var dayAccessibilityText: String?

  var isHighlighted = false {
    didSet {
      updateHighlightIndicator()
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    dayofWeekLabel.frame = bounds
    layer.cornerRadius = min(bounds.width, bounds.height) / 2
  }

  // MARK: Private

  private let dayofWeekLabel: UILabel

  private func updateHighlightIndicator() {
    backgroundColor = isHighlighted ? UIColor.black.withAlphaComponent(0.1) : .clear
  }

}

// MARK: UIAccessibility

extension DayOfWeekView {

  override var isAccessibilityElement: Bool {
    get { true }
    set { }
  }

  override var accessibilityLabel: String? {
    get { dayAccessibilityText ?? dayText }
    set { }
  }

}

// MARK: CalendarItemViewRepresentable

extension DayOfWeekView: CalendarItemViewRepresentable {

  struct InvariantViewProperties: Hashable {
    var font = UIFont.systemFont(ofSize: 18 )
    var textAlignment = NSTextAlignment.center
    var textColor: UIColor
  }

  struct ViewModel: Equatable {
    let dayText: String
    let dayAccessibilityText: String?
  }

  static func makeView(
    withInvariantViewProperties invariantViewProperties: InvariantViewProperties)
    -> DayOfWeekView
  {
    DayOfWeekView(invariantViewProperties: invariantViewProperties)
  }

  static func setViewModel(_ viewModel: ViewModel, on view: DayOfWeekView) {
    view.dayText = viewModel.dayText
    view.dayAccessibilityText = viewModel.dayAccessibilityText
  }

}
