//
//  User.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct User: Mappable, Created {

  // MARK: Thing
  var identifier: String!
  var name: String!
  var kind: String!

  // MARK: Created
  var created: NSDate!

  // MARK: User
  var username: String!
  var commentKarma: Int!
  var linkKarma: Int!
  var hasMail: Bool!
  var hasModeratorMail: Bool!
  var hasVerifiedEmailAddress: Bool!
  var isGold: Bool!
  var isFriend: Bool!
  var isMod: Bool!
  var over18: Bool!

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingCreated(map)
    mappingUser(map)
  }

  private mutating func mappingUser(map: Map) {
    username <- map["data.name"]
    commentKarma <- map["data.comment_karma"]
    linkKarma <- map["data.link_karma"]
    hasMail <- (map["data.has_mail"], NilBoolTransform())
    hasModeratorMail <- (map["data.has_mod_mail"], NilBoolTransform())
    hasVerifiedEmailAddress <- (map["data.has_verified_email"], NilBoolTransform())
    isGold <- map["data.is_gold"]
    isFriend <- map["data.is_friend"]
    isMod <- map["data.is_mod"]
    over18 <- map["data.over_18"]
  }
}
