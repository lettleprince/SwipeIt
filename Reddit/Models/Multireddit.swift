//
//  Multireddit.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Multireddit: Mappable {

  // MARK: Multireddit
  var name: String!
  var displayName: String!
  var path: String!
  var url: NSURL!
  var descriptionHTML: String?
  var descriptionMarkdown: String?
  var copiedFrom: String?
  var subreddits: [String]!
  var iconURL: NSURL?
  var editable: Bool!
  var visibility: MultiredditVisibility!
  var created: NSDate!
  var keyColor: String?
  var iconName: String?

  lazy var username: String? = {
    do {
      let regex = try NSRegularExpression(pattern: "http://reddit.com/user/(.*)/m/", options: [])
      let path = self.url.absoluteString
      if let firstMatch = regex
        .firstMatchInString(path, options: [],
                            range: NSRange(location: 0, length: path.characters.count)) {
        let nsRange = firstMatch.rangeAtIndex(1)
        let initialIndex = path.startIndex.advancedBy(nsRange.location)
        let endIndex = path.startIndex.advancedBy(nsRange.location + nsRange.length)

        return path.substringWithRange(initialIndex..<endIndex)
      }
    } catch { }
    return nil
  }()

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    name <- map["data.name"]
    displayName <- map["data.display_name"]
    url <- (map["data.path"], PermalinkTransform())
    path <- (map["data.path"], PathTransform())
    descriptionHTML <- map["data.description_html"]
    descriptionMarkdown <- map["data.description_md"]
    copiedFrom <- map["data.copied_from"]
    editable <- map["data.can_edit"]
    subreddits <- (map["data.subreddits"], JSONKeyTransform("name"))
    visibility <- map["data.visibility"]
    created <- (map["data.created_utc"], EpochDateTransform())
    iconURL <- (map["data.icon_url"], EmptyURLTransform())
    keyColor <- (map["data.key_color"], EmptyStringTransform())
    iconName <- (map["data.icon_name"], EmptyStringTransform())
  }

}
