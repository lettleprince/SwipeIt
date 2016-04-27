//
//  Likes.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum Voted: Equatable {

  case Upvoted
  case Downvoted
  case None

  var value: Bool? {
    switch self {
    case .Upvoted:
      return true
    case .Downvoted:
      return false
    case .None:
      return nil
    }
  }

  static func fromBool(bool: Bool?) -> Voted {
    guard let bool = bool else {
      return .None
    }
    return bool ? .Upvoted : .Downvoted
  }

}

func == (lhs: Voted, rhs: Voted) -> Bool {
  switch (lhs, rhs) {
  case (.Downvoted, .Downvoted):
    return true
  case (.Upvoted, .Upvoted):
    return true
  case (.None, .None):
    return true
  default:
    return false
  }
}
