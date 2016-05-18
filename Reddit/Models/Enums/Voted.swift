//
//  Likes.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum Vote: Int {

  case Upvote = 1
  case Downvote = -1
  case None = 0

  var value: Bool? {
    switch self {
    case .Upvote:
      return true
    case .Downvote:
      return false
    case .None:
      return nil
    }
  }

  static func fromBool(bool: Bool?) -> Vote {
    guard let bool = bool else {
      return .None
    }
    return bool ? .Upvote : .Downvote
  }

}
