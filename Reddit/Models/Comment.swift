//
//  Comment.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Comment: Votable, Mappable {

  // MARK: Constants
  private static let deletedString = "[deleted]"

  // MARK: Thing
  var identifier: String!
  var name: String!
  var kind: String!

  // MARK: Votable
  var downs: Int!
  var ups: Int!
  var vote: Vote!
  var score: Int!

  // MARK: Created
  var created: NSDate!

  // MARK: Comment
  var approvedby: String?
  var author: String!
  var linkAuthor: String?
  var authorFlairClass: String!
  var authorFlairText: String?
  var bannedBy: String?
  var body: String!
  var bodyHTML: String!
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
  var replies: CommentsListing?
  var submissionContentText: String?
  var submissionContentHTML: String?
  var submissionLink: String?
  var submissionParent: String?
  var distinguished: Distinguished?
  var removalReason: String?
  var userReports: [String]?
  var modReports: [String]?
  var reportReasons: String?
  var stickied: Bool!

  // MARK: Accessors
  var deleted: Bool {
    return author == Comment.deletedString && body == Comment.deletedString
  }

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingVotable(map)
    mappingComment(map)
  }

  private mutating func mappingComment(map: Map) {
    approvedby <- map["data.approved_by"]
    bannedBy <- map["data.banned_by"]
    author <- map["data.author"]
    linkAuthor <- map["data.link_author"]
    body <- map["data.body"]
    bodyHTML <- map["data.body_html"]
    scoreHidden <- map["data.score_hidden"]
    replies <- map["data.replies"]
    edited <- (map["data.edited"], EditedTransform())
    archived <- map["data.archived"]
    saved <- map["data.saved"]
    linkId <- map["data.link_id"]
    gilded <- map["data.gilded"]
    score <- map["data.score"]
    controversiality <- map ["data.controversiality"]
    parentId <- map["data.parent_id"]
    subreddit <- map["data.subreddit"]
    subredditId <- map["data.subreddit_id"]
    authorFlairText <- map["data.author_flair_text"]
    authorFlairClass <- map["data.author_flair_css_class"]
    totalReports <- (map["data.num_reports"], ZeroDefaultTransform())
    submissionContentText <- map["data.contentText"]
    submissionContentHTML <- map["data.contentHTML"]
    submissionLink <- map["data.link"]
    submissionParent <- map["data.parent"]
    distinguished <- map["data.distinguished"]
    removalReason <- map["data.removal_reason"]
    userReports <- (map["data.user_reports"], EmptyArrayTransform())
    modReports <- (map["data.mod_reports"], EmptyArrayTransform())
    reportReasons <- map["data.report_reasons"]
    stickied <- map["data.stickied"]
  }

}
