//
//  Globals.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import KeychainSwift
import ObjectMapper

// MARK: Generic
class Globals {

  private static let keychain = KeychainSwift()

}

// MARK: Keychain
extension Globals {

  static var accessToken: AccessToken? {
    get {
      guard let jsonString = keychain.get("accessToken") else { return nil }
      return Mapper<AccessToken>().map(jsonString)
    }
    set {
      if let accessToken = newValue, jsonString = accessToken.toJSONString() {
        keychain.set(jsonString, forKey: "accessToken")
      } else {
        keychain.delete("accessToken")
      }
    }
  }
}
