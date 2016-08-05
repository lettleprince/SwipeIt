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
  case Controversial(range: ListingTypeRange)
  case Top(range: ListingTypeRange)
  case Gilded

  var path: String {
    switch self {
    case .Hot:
      return "hot"
    case .New:
      return "new"
    case .Rising:
      return "rising"
    case .Controversial:
      return "controversial"
    case .Top:
      return "top"
    case .Gilded:
      return "gilded"
    }
  }



  var range: ListingTypeRange? {
    switch self {
    case .Controversial(let range):
      return range
    case .Top(let range):
      return range
    default:
      return nil
    }
  }



  static func typeAtIndex(index: Int, range: ListingTypeRange? = nil) -> ListingType? {
    switch index {
    case 0:
      return .Hot
    case 1:
      return .New
    case 2:
      return .Rising
    case 3:
      guard let range = range else { return nil }
      return .Controversial(range: range)
    case 4:
      guard let range = range else { return nil }
      return .Top(range: range)
    case 5:
      return .Gilded
    default:
      return .Hot
    }
  }

}

enum ListingTypeRange: String {
  case Hour = "hour"
  case Day = "day"
  case Week = "week"
  case Month = "month"
  case Year = "year"
  case AllTime = "all"

  static var ranges: [ListingTypeRange] {
    return [.Hour, .Day, .Week, .Month, .Year, .AllTime]
  }

  static func rangeAtIndex(index: Int) -> ListingTypeRange? {
    return ranges.get(index)
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
  case (.Controversial(let lhsRange), .Controversial(let rhsRange)):
    return lhsRange == rhsRange
  case (.Top(let lhsRange), .Top(let rhsRange)):
    return lhsRange == rhsRange
  case (.Gilded, .Gilded):
    return true
  default:
    return false
  }
}
