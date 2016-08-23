//
//  Array+Optional.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// MARK: - Array Optional Getter
extension Array {

  /// Safely lookup an index that might be out of bounds,
  /// returning nil if it does not exist

  /**
   Looks for a value for a given index on an array. Returns the value or nil in case
   it does not exist.

   - parameter index: The index for the lookup

   - returns: The value in the array or nil in case it does not exist.
   */
  func get(index: Int) -> Element? {
    if 0 <= index && index < count {
      return self[index]
    } else {
      return nil
    }
  }
}
