//
//  ZeroDefaultTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class ZeroDefaultTransform: TransformType {
  public typealias Object = Int
  public typealias JSON = Int

  public init() {}

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? Int else {
      return 0
    }
    return value
  }

  public func transformToJSON(value: Object?) -> Int? {
    return value
  }
}
