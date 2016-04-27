//
//  ListingType.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum ListingType: Equatable {

  case Hot
  case New
  case Rising
  case Random
  case Controversial(range: ListingTypeRange)
  case Top(range: ListingTypeRange)

  var path: String {
    switch self {
    case .Hot:
      return "hot"
    case .New:
      return "new"
    case .Rising:
      return "rising"
    case .Random:
      return "random"
    case .Controversial(let range):
      return "controversial/\(range)"
    case .Top(let range):
      return "top/\(range)"
    }
  }

  enum ListingTypeRange: String {
    case Hour = "hour"
    case Day = "day"
    case Week = "week"
    case Month = "month"
    case Year = "year"
  }

}

func == (lhs: ListingType, rhs: ListingType) -> Bool {
  switch (lhs, rhs) {
  case (.Hot, .Hot):
    return true
  case (.New, .New):
    return true
  case (.Rising, .Rising):
    return true
  case (.Random, .Random):
    return true
  case (.Controversial(let lhsRange), .Controversial(let rhsRange)):
    return lhsRange == rhsRange
  case (.Top(let lhsRange), .Top(let rhsRange)):
    return lhsRange == rhsRange
  default:
    return false
  }
}
