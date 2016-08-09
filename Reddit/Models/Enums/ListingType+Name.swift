//
//  ListingType+Name.swift
//  Reddit
//
//  Created by Ivan Bruel on 05/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension ListingType {

  var name: String {
    switch self {
    case .Hot:
      return tr(.ListingTypeHot)
    case .New:
      return tr(.ListingTypeNew)
    case .Rising:
      return tr(.ListingTypeRising)
    case .Controversial:
      return tr(.ListingTypeControversial)
    case .Top:
      return tr(.ListingTypeTop)
    case .Gilded:
      return tr(.ListingTypeGilded)
    }
  }

  static var names: [String] {
    return [tr(.ListingTypeHot), tr(.ListingTypeNew), tr(.ListingTypeRising),
            tr(.ListingTypeControversial), tr(.ListingTypeTop)]
    //tr(.ListingTypeGilded)] Removed until comments are added
  }

}

extension ListingTypeRange {

  static var names: [String] {
    return [tr(.ListingTypeRangeHour), tr(.ListingTypeRangeDay), tr(.ListingTypeRangeWeek),
            tr(.ListingTypeRangeMonth), tr(.ListingTypeRangeYear), tr(.ListingTypeRangeAllTime)]
  }
}
