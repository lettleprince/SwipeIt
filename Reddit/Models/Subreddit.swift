//
//  Subreddit.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Subreddit: Mappable, Created {

  // MARK: Thing
  var identifier: String!
  var name: String!
  var kind: String!

  // MARK: Created
  var created: NSDate!

  // MARK: Subreddit
  var bannerImage: NSURL?
  var submitTextHTML: String?
  var wikiEnabled: Bool!
  var submitText: String?
  var displayName: String!
  var headerImage: NSURL?
  var descriptionHTML: String?
  var title: String!
  var collapseDeletedComments: Bool!
  var publicDescription: String?
  var nsfw: Bool!
  var publicDescriptionHTML: String?
  var iconWidth: Int?
  var iconHeight: Int?
  var suggestedCommentSort: String?
  var iconImage: NSURL?
  var headerTitle: String?
  var description: String?
  var submitLinkLabel: String?
  var accountsActive: Int?
  var publicTraffic: Bool!
  var headerWidth: Int?
  var headerHeight: Int?
  var totalSubscribers: Int!
  var submitTextLabel: String?
  var language: String!
  var keyColor: String?
  var url: NSURL!
  var quarantine: Bool!
  var hideAds: Bool!
  var bannerWidth: Int?
  var bannerHeight: Int?
  var commentScoreHideMins: Int!
  var subredditType: SubredditType!
  var submissionType: SubmissionType!

  // MARK: User
  var userIsSubscriber: Bool!
  var userSubredditThemeEnabled: Bool!
  var userIsMuted: Bool!
  var userIsContributor: Bool!
  var userIsBanned: Bool!
  var userIsModerator: Bool!

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingCreated(map)
    mappingSubreddit(map)
    mappingUser(map)
  }

  private mutating func mappingSubreddit(map: Map) {
    bannerImage <- (map["data.banner_img"], EmptyURLTransform())
    submitTextHTML <- (map["data.submit_text_html"], EmptyStringTransform())
    wikiEnabled <- map["data.wiki_enabled"]
    submitText <- (map["data.submit_text"], EmptyStringTransform())
    displayName <- map["data.display_name"]
    headerImage <- (map["data.header_img"], EmptyURLTransform())
    descriptionHTML <- (map["data.description_html"], EmptyStringTransform())
    title <- map["data.title"]
    collapseDeletedComments <- map["data.collapse_deleted_comments"]
    publicDescription <- (map["data.public_description"], EmptyStringTransform())
    nsfw <- map["data.over18"]
    publicDescriptionHTML <- (map["data.public_description_html"], EmptyStringTransform())
    iconWidth <- map["data.icon_size.0"]
    iconHeight <- map["data.icon_size.1"]
    suggestedCommentSort <- map["data.suggested_comment_sort"]
    iconImage <- (map["data.icon_img"], EmptyURLTransform())
    headerTitle <- (map["data.header_title"], EmptyStringTransform())
    description <- (map["data.description"], EmptyStringTransform())
    submitLinkLabel <- (map["data.submit_link_label"], EmptyStringTransform())
    accountsActive <- map["data.accounts_active"]
    publicTraffic <- map["data.public_traffic"]
    headerWidth <- map["data.header_size.0"]
    headerHeight <- map["data.header_size.1"]
    totalSubscribers <- (map["data.subscribers"], ZeroDefaultTransform())
    submitTextLabel <- (map["data.submit_text_label"], EmptyStringTransform())
    language <- map["data.lang"]
    keyColor <- (map["data.key_color"], EmptyStringTransform())
    url <- (map["data.url"], PermalinkTransform())
    quarantine <- map["data.quarantine"]
    hideAds <- map["data.hide_ads"]
    bannerWidth <- map["data.banner_size.0"]
    bannerHeight <- map["data.banner_size.1"]
    commentScoreHideMins <- map["data.comment_score_hide_mins"]
    subredditType <- map["data.subreddit_type"]
    submissionType <- map["data.submission_type"]
  }

  private mutating func mappingUser(map: Map) {
    userIsSubscriber <- map["data.user_is_subscriber"]
    userIsModerator <- map["data.user_is_moderator"]
    userSubredditThemeEnabled <- map["data.user_sr_theme_enabled"]
    userIsBanned <- map["data.user_is_banned"]
    userIsMuted <- map["data.user_is_muted"]
    userIsContributor <- map["data.user_is_contributor"]
  }
}
