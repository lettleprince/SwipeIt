//
//  NowDateTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

class NowDateTransform: TransformType {
  typealias Object = NSDate
  typealias JSON = Int

  private let now: NSDate

  init(now: NSDate) {
    self.now = now
  }

  func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? Int else {
      return nil
    }
    return now.dateByAddingTimeInterval(Double(value))
  }

  func transformToJSON(value: Object?) -> JSON? {
    return value.flatMap { Int($0.timeIntervalSinceDate(now)) }
  }
}
