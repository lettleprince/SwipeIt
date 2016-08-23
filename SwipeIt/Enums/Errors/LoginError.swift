//
//  LoginError.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// MARK: - Enum Values
enum LoginError: ErrorType {

  /// User cancelled the login
  case UserCancelled
  /// Any other error
  case Unknown
}

// MARK: - Printable
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
