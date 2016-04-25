//
//  Edited.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum Edited: Equatable {

  case False
  case True(editedAt: NSDate?)

  var editedAt: NSDate? {
    switch self {
    case .True(let date):
      return date
    default:
      return nil
    }
  }

  var value: AnyObject {
    switch self {
    case .False:
      return false
    case .True(let editedAt):
      guard let editedAt = editedAt else {
        return true
      }
      return Int(editedAt.timeIntervalSince1970)
    }
  }

  static func fromValue(value: AnyObject?) -> Edited {
    switch value {
    case let edited as Bool:
      return edited ? .True(editedAt: nil) : .False
    case let epochDate as Int:
      return .True(editedAt: (NSDate(timeIntervalSince1970: Double(epochDate))))
        default:
      return .False
    }
  }
}

func == (lhs: Edited, rhs: Edited) -> Bool {
  switch (lhs, rhs) {
  case (.False, .False):
    return true
  case (.False, .True), (.True, .False):
    return false
  case (.True(let lhsDate), .True(let rhsDate)):
    guard let lhsDateValue = lhsDate, rhsDateValue = rhsDate else {
      return lhsDate == rhsDate
    }
    return lhsDateValue.compare(rhsDateValue) == .OrderedSame
  }
}
