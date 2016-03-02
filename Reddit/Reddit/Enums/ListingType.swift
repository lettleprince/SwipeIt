//
//  ListingType.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum ListingType {
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
    case .Top(let top):
      return "controversial/\(top)"
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
