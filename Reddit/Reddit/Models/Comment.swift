//
//  Comment.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Comment: Thing, Created, Votable, Mappable {

  // Thing
  var identifier: String!
  var name: String!
  var kind: String!

  // Votable
  var downs: Int!
  var ups: Int!
  var likes: Likes!
  var score: Int!

  // Created
  var created: NSDate!

  // Comment
  var approvedby: String?
  var author: String!
  var authorFlairCssClass: String!
  var authorFlairText: String?
  var bannedBy: String?
  var body: String!
  var bodyHtml: String!
  var edited: Edited!
  var gilded: Int!
  var archived: Bool!
  var saved: Bool!
  var linkId: String!
  var linkTitle: String!
  var totalReports: Int!
  var parentId: String?
  var scoreHidden: Bool!
  var controversiality: Int!
  var subreddit: String!
  var subredditId: String!
  var replies: [Comment]!

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingThing(map)
    mappingVotable(map)
    mappingCreated(map)
  }

}
