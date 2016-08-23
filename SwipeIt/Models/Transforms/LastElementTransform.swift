//
//  LastElementTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 28/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class LastElementTransform<T: Mappable>: TransformType {
  public typealias Object = T
  public typealias JSON = [[String: AnyObject]]

  public init() { }

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? JSON else {
      return nil
    }
    return Mapper<Object>().map(value.last)
  }

  public func transformToJSON(value: Object?) -> JSON? {
    guard let value = value else {
      return nil
    }
    return [Mapper<Object>().toJSON(value)]
  }
}
