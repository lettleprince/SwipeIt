//
//  Likes.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum Likes: Equatable {

  case True
  case False
  case NoVote

  var value: Bool? {
    switch self {
    case .True:
      return true
    case .False:
      return false
    case .NoVote:
      return nil
    }
  }

  static func fromBool(bool: Bool?) -> Likes {
    guard let bool = bool else {
      return .NoVote
    }
    return bool ? .True : .False
  }

}

func == (lhs: Likes, rhs: Likes) -> Bool {
  switch (lhs, rhs) {
  case (.False, .False):
    return true
  case (.True, .True):
    return true
  case (.NoVote, .NoVote):
    return true
  default:
    return false
  }
}
