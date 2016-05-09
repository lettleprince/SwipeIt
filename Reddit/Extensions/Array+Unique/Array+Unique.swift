//
//  Array+Unique.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

  // Returns only the unique elements out of an array
  func unique() -> [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      if !uniqueValues.contains(item) {
        uniqueValues += [item]
      }
    }
    return uniqueValues
  }
}
