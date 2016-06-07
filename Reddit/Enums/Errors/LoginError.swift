//
//  LoginError.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum LoginError: ErrorType {

  case UserCancelled
  case Unknown

}

extension LoginError: CustomStringConvertible {

  var description: String {
    switch self {
    case .UserCancelled:
      return tr(.LoginErrorUserCancelled)
    case .Unknown:
      return tr(.LoginErrorUnknown)
    }
  }
}
