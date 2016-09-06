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

  private static let userDefaults = NSUserDefaults.userDefaults
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

// MARK: User Defaults
extension Globals {

  static var hideVotedPosts: Bool {
    get {
      return userDefaults.boolForKey("hideVotedPosts")
    }
    set {
      userDefaults.setBool(newValue, forKey: "hideVotedPosts")
    }
  }

  static var selfPostNumberOfLines: Int {
    get {
      return userDefaults.objectForKey("selfPostNumberOfLines") as? Int ?? 5
    }
    set {
      userDefaults.setInteger(newValue, forKey: "selfPostNumberOfLines")
    }
  }

  static var theme: Theme? {
    get {
      return Theme(optionalRawValue: userDefaults.stringForKey("theme"))
    }
    set {
      if let theme = newValue {
        userDefaults.setObject(theme.rawValue, forKey: "theme")
      } else {
        userDefaults.removeObjectForKey("theme")
      }
    }
  }
}
