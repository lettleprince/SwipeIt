//
//  PermalinkTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class PermalinkTransform: TransformType {
  public typealias Object = NSURL
  public typealias JSON = String

  public init() {}

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? String else {
      return nil
    }
    let fullPermalink = "\(Constants.redditURL)\(value)"
    return NSURL(string: fullPermalink)
  }

  public func transformToJSON(value: Object?) -> String? {
    return value?.absoluteString
  }
}
