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
  typealias JSON = String

  init() {}

  func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? String,
      doubleValue = Double(value) else {
      return nil
    }
    return NSDate(timeIntervalSinceNow: doubleValue)
  }

  func transformToJSON(value: Object?) -> JSON? {
    return value.flatMap { String($0.timeIntervalSinceNow) }
  }
}
