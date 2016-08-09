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
struct Link: Votable, Mappable {

  private static let imageExtensionRegex = "(.jpe?g|.png|.gif)"
  private static let imageURLRegexes = ["^https?://.*imgur.com/", "^https?://.*reddituploads.com/",
                                        "^https?://(?: www.)?gfycat.com/",
                                        "^https?://.*.media.tumblr.com/", imageExtensionRegex]
  private static let redditShortURL = NSURL(string: "http://redd.it/")!
  private static let redditURL = NSURL(string: Constants.redditURL)!

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

  // MARK: Link
  var author: String!
  var authorFlairClass: String?
  var authorFlairText: String?
  var clicked: Bool!
  var domain: String!
  var hidden: Bool!
  var selfPost: Bool!
  var linkFlairClass: String?
  var linkFlairText: String?
  var locked: Bool!
  var upvoteRatio: Float?
  var media: Media?
  var secureMedia: Media?
  var embeddedMedia: EmbeddedMedia?
  var secureEmbeddedMedia: EmbeddedMedia?
  var previewImages: [PreviewImage]?
  var totalComments: Int!
  var nsfw: Bool!
  var permalink: String!
  var saved: Bool!
  var selfText: String?
  var selfTextHTML: String?
  var subreddit: String!
  var subredditId: String!
  var thumbnailURL: NSURL?
  var title: String!
  var url: NSURL!
  var edited: Edited!
  var distinguished: Distinguished?
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
  var totalReports: Int!

  // MARK: Accessors
  var subredditURL: NSURL {
    return NSURL(string: "\(Constants.redditURL)/r/\(subreddit)")!
  }

  var authorURL: NSURL {
    return NSURL(string: "\(Constants.redditURL)/u/\(author)")!
  }

  private var previewImage: PreviewImage? {
    return previewImages?.first
  }

  var imageURL: NSURL? {
    if let imageURL = ImgurImageProvider.imageURLFromLink(self)
      ?? previewImage?.gifSource?.url
      ?? previewImage?.nsfwSource?.url
      ?? previewImage?.source.url {
      return imageURL
    }
    return url.absoluteString.matchesWithRegex(Link.imageExtensionRegex) ? url : nil
  }

  var isSpoiler: Bool {
    return title.lowercaseString.containsString("spoiler")
  }

  var type: LinkType {
    return LinkType.typeFromLink(self)
  }

  var imageSize: CGSize? {
    return previewImage?.gifSource?.size ?? previewImage?.nsfwSource?.size
      ?? previewImage?.source.size
  }

  var shortURL: NSURL {
    return Link.redditShortURL.URLByAppendingPathComponent(identifier)
  }

  var permalinkURL: NSURL {
    return Link.redditURL.URLByAppendingPathComponent(permalink)
  }

  var scoreWithoutVote: Int {
    if vote == .Upvote {
      return score - 1
    } else if vote == .Downvote {
      return score + 1
    }
    return score
  }

  func scoreWithVote(voted: Vote) -> Int {
    switch voted {
    case .Upvote:
      return scoreWithoutVote + 1
    case .Downvote:
      return scoreWithoutVote - 1
    case .None:
      return scoreWithoutVote
    }
  }

  // MARK: JSON
  init?(_ map: Map) {
    // Fail if no data is found
    guard let _ = map.JSONDictionary["data"] else { return nil }
  }

  mutating func mapping(map: Map) {
    mappingVotable(map)
    mappingLink(map)
    mappingMisc(map)
  }

  private mutating func mappingLink(map: Map) {
    author <- map["data.author"]
    upvoteRatio <- map["data.upvote_ratio"]
    authorFlairClass <- map["data.author_flair_css_class"]
    authorFlairText <- (map["data.author_flair_text"], EmptyStringTransform())
    clicked <- map["data.clicked"]
    domain <- map["data.domain"]
    hidden <- map["data.hidden"]
    selfPost <- map["data.is_self"]
    linkFlairClass <- map["data.link_flair_css_class"]
    linkFlairText <- (map["data.link_flair_text"], EmptyStringTransform())
    locked <- map["data.locked"]
    media <- map["data.media"]
    secureMedia <- map["data.secure_media"]
    embeddedMedia <- map["data.media_embed"]
    secureEmbeddedMedia <- map["data.secure_media_embed"]
    thumbnailURL <- map["data.thumbnail"]
    totalComments <- map["data.num_comments"]
    nsfw <- map["data.over_18"]
    permalink <- map["data.permalink"]
    saved <- map["data.saved"]
    selfText <- (map["data.selftext"], EmptyStringTransform())
    selfTextHTML <- map["data.selftext_html"]
    subreddit <- map["data.subreddit"]
    subredditId <- map["data.subreddit_id"]
    thumbnailURL <- (map["data.thumbnail"], EmptyURLTransform())
    title <- (map["data.title"], HTMLEncodingTransform())
    url <- (map["data.url"], EmptyURLTransform())
    edited <- (map["data.edited"], EditedTransform())
    distinguished <- map["data.distinguished"]
    stickied <- map["data.stickied"]
    gilded <- map["data.gilded"]
    visited <- map["data.visited"]
    previewImages <- map["data.preview.images"]
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
    totalReports <- (map["data.num_reports"], ZeroDefaultTransform())
  }
}
