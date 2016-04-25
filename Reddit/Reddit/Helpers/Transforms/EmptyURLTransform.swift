//
//  EmptyURLTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class EmptyURLTransform: TransformType {
  public typealias Object = NSURL
  public typealias JSON = String

  public init() {}

  public func transformFromJSON(value: AnyObject?) -> NSURL? {
    if let URLString = value as? String where URLString.characters.count > 0 {
      return NSURL(string: URLString)
    }
    return nil
  }

  public func transformToJSON(value: NSURL?) -> String? {
    if let URL = value {
      return URL.absoluteString
    }
    return nil
  }
}
