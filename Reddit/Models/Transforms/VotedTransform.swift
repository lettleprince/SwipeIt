//
//  VoteTransform.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

class VoteTransform: TransformType {
  typealias Object = Vote
  typealias JSON = Bool

  init() {}

  func transformFromJSON(value: AnyObject?) -> Object? {
    return Vote.fromBool(value as? JSON)
  }

  func transformToJSON(value: Object?) -> JSON? {
    return value?.value
  }
}
