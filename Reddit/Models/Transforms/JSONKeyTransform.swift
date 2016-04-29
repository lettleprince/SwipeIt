//
//  JSONKeyTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 28/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

public class JSONKeyTransform: TransformType {
  public typealias Object = [String]
  public typealias JSON = [[String: String]]

  private let key: String

  public init(_ key: String) {
    self.key = key
  }

  public func transformFromJSON(value: AnyObject?) -> Object? {
    guard let value = value as? JSON else {
      return nil
    }
    return value.flatMap { $0[self.key] }
  }

  public func transformToJSON(value: Object?) -> JSON? {
    return value?.map { [self.key: $0] }
  }
}
