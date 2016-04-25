//
//  MediaEmbed.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct MediaEmbed: Mappable {

  var content: String!
  var scrolling: Bool!
  var width: Int!
  var height: Int!

  // MARK: JSON
  init?(_ map: Map) {
    guard map.JSONDictionary.count > 0 else {
      return nil
    }
  }

  mutating func mapping(map: Map) {
    content <- map["content"]
    scrolling <- map["scrolling"]
    width <- map["width"]
    height <- map["height"]
  }

}
