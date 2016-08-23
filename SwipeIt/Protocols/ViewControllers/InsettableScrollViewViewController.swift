//
//  ScrollInsettedViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

// This protocol requires saving a topScrollInset to a variable instead of setting it directly to
// the scrollView because of potential view controllers where the scrollView is not present at the
// parent view controller's viewDidLoad call.
protocol InsettableScrollViewViewController: class {

  var topScrollInset: CGFloat { get set }

  func setupInsettableScrollView(scrollView: UIScrollView)
}

extension InsettableScrollViewViewController {

  func setupInsettableScrollView(scrollView: UIScrollView) {
    var insets = scrollView.contentInset
    insets.top = topScrollInset
    scrollView.contentInset = insets
    scrollView.scrollIndicatorInsets = insets
  }
}
