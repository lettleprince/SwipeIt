//
//  AccessToken.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct AccessToken: Mappable {

  // MARK: AccessToken
  var token: String!
  var tokenType: String!
  var expiresIn: NSDate!
  var scope: String!
  var refreshToken: String!

  // MARK: JSON
  init?(_ map: Map) {
    guard let _ = map.JSONDictionary["access_token"] else {
      return nil
    }
  }

  mutating func mapping(map: Map) {
    token <- map["access_token"]
    tokenType <- map["token_type"]
    expiresIn <- (map["expires_in"], NowDateTransform())
    scope <- map["scope"]
    refreshToken <- map["refresh_token"]
  }
}
