//
//  HTMLEncodingTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class HTMLEncodingTransform: TransformType {
  public typealias Object = String
  public typealias JSON = String

  public init() {}

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? String else {
      return nil
    }
    return value.stringByDecodingHTMLEntities
  }

  public func transformToJSON(value: Object?) -> String? {
    return value
  }
}
