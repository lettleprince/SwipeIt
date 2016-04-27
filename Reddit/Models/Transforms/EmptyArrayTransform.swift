//
//  EmptyArrayTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

class EmptyArrayTransform: TransformType {
  typealias Object = [String]
  typealias JSON = [String]

  init() {}

  func transformFromJSON(value: AnyObject?) -> Object? {
    guard let array = value as? [String] where array.count > 0 else {
      return nil
    }
    return array
  }

  func transformToJSON(value: Object?) -> JSON? {
    return value
  }
}
