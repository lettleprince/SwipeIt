//
//  Link.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

// https://github.com/reddit/reddit/wiki/JSON
struct Link: Thing, Created, Votable, Mappable {

  // MARK: Thing
  var identifier: String!
  var name: String!
  var kind: String!

  // MARK: Votable
  var downs: Int!
  var ups: Int!
  var likes: Likes!
  var score: Int!

  // MARK: Created
  var created: NSDate!

  // MARK: Link
  var author: String?
  var authorFlairCssClass: String?
  var authorFlairText: String?
  var clicked: Bool!
  var domain: String!
  var hidden: Bool!
  var isSelf: Bool!
  var linkFlairCssClass: String?
  var linkFlairText: String?
  var locked: Bool!
  var media: Media?
  var secureMedia: Media?
  var mediaEmbed: MediaEmbed?
  var secureMediaEmbed: MediaEmbed?
  var preview: [PreviewImage]?
  var numComments: Int!
  var nsfw: Bool!
  var permalink: String!
  var saved: Bool!
  var selfText: String?
  var selfTextHtml: String?
  var subreddit: String!
  var subredditId: String!
  var thumbnail: NSURL?
  var title: String!
  var url: NSURL!
  var edited: Edited!
  var distinguished: String?
  var stickied: Bool!
  var gilded: Int!
  var visited: Bool!

  // MARK: Misc
  var approvedBy: String!
  var bannedBy: String?
  var suggestedSort: String?
  var userReports: [String]?
  var fromKind: String?
  var archived: Bool!
  var reportReasons: String?
  var hideScore: Bool!
  var removalReason: String?
  var from: String?
  var fromId: String?
  var quarantine: Bool!
  var modReports: [String]?
  var numReports: Int?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingThing(map)
    mappingVotable(map)
    mappingCreated(map)
    mappingLink(map)
    mappingMisc(map)
  }

  private mutating func mappingLink(map: Map) {
    author <- map["data.author"]
    authorFlairCssClass <- map["data.author_flair_css_class"]
    authorFlairText <- map["data.author_flair_text"]
    clicked <- map["data.clicked"]
    domain <- map["data.domain"]
    hidden <- map["data.hidden"]
    isSelf <- map["data.is_self"]
    linkFlairCssClass <- map["data.link_flair_css_class"]
    linkFlairText <- map["data.link_flair_text"]
    locked <- map["data.locked"]
    media <- map["data.media"]
    secureMedia <- map["data.secure_media"]
    mediaEmbed <- map["data.media_embed"]
    secureMediaEmbed <- map["data.secure_media_embed"]
    preview <- map["data.preview.images"]
    numComments <- map["data.num_comments"]
    nsfw <- map["data.over_18"]
    permalink <- map["data.permalink"]
    saved <- map["data.saved"]
    selfText <- (map["data.selftext"], EmptyStringTransform())
    selfTextHtml <- map["data.selftext_html"]
    subreddit <- map["data.subreddit"]
    subredditId <- map["data.subreddit_id"]
    thumbnail <- (map["data.thumbnail"], EmptyURLTransform())
    title <- map["data.title"]
    url <- (map["data.url"], EmptyURLTransform())
    edited <- (map["data.edited"], EditedTransform())
    distinguished <- map["data.distinguished"]
    stickied <- map["data.stickied"]
    gilded <- map["data.gilded"]
    visited <- map["data.visited"]
  }

  private mutating func mappingMisc(map: Map) {
    approvedBy <- map["data.approved_by"]
    bannedBy <- map["data.banned_by"]
    suggestedSort <- map["data.suggested_sort"]
    userReports <- (map["data.user_reports"], EmptyArrayTransform())
    fromKind <- map["data.from_kind"]
    archived <- map["data.archived"]
    reportReasons <- map["data.report_reasons"]
    hideScore <- map["data.hide_score"]
    removalReason <- map["data.removal_reason"]
    from <- map["data.from"]
    fromId <- map["data.from_id"]
    quarantine <- map["data.quarantine"]
    modReports <- (map["data.mod_reports"], EmptyArrayTransform())
    numReports <- map["data.num_reports"]
  }

}
