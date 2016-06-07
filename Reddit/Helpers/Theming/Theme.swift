//
//  Theme.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

enum Theme: String {
  case Light
  case Dark

  var textColor: UIColor {
    switch self {
    case .Light:
      return .darkTextColor()
    case .Dark:
      return .lightTextColor()
    }
  }

  var secondaryTextColor: UIColor {
    switch self {
    case .Light:
      return .darkGrayColor()
    case .Dark:
      return .lightGrayColor()
    }
  }

  var accentColor: UIColor {
    switch self {
    default:
      return UIColor(named: .IOSBlue)
    }
  }

  var backgroundColor: UIColor {
    switch self {
    case .Light:
      return .whiteColor()
    case .Dark:
      return .darkGrayColor()
    }
  }
}
