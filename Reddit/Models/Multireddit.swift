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
  var descriptionHTML: String?
  var descriptionMarkdown: String?
  var copiedFrom: String?
  var subreddits: [String]!
  var editable: Bool!
  var visibility: MultiredditVisibility!
  var created: NSDate!

  lazy var username: String? = {
    do {
      let regex = try NSRegularExpression(pattern: "/user/(.*)/m/", options: [])
      if let firstMatch = regex
        .firstMatchInString(self.path, options: [],
                            range: NSRange(location: 0, length: self.path.characters.count)) {
        let nsRange = firstMatch.rangeAtIndex(1)
        let initialIndex = self.path.startIndex.advancedBy(nsRange.location)
        let endIndex = self.path.startIndex.advancedBy(nsRange.location + nsRange.length)

        return self.path.substringWithRange(initialIndex..<endIndex)
      }
    } catch { }
    return nil
  }()

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    name <- map["data.name"]
    displayName <- map["data.display_name"]
    path <- map["data.path"]
    descriptionHTML <- map["data.description_html"]
    descriptionMarkdown <- map["data.description_md"]
    copiedFrom <- map["data.copied_from"]
    editable <- map["data.can_edit"]
    subreddits <- map["data.subreddits.name"]
    visibility <- map["data.visibility"]
    created <- (map["data.created_utc"], EpochDateTransform())
  }

}
