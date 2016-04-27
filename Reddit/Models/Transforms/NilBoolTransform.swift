//
//  NilBoolTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class NilBoolTransform: TransformType {
  public typealias Object = Bool
  public typealias JSON = Bool

  public init() {}

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? Object else {
      return false
    }
    return value
  }

  public func transformToJSON(value: Object?) -> JSON? {
    return value
  }
}
