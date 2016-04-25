//
//  Media.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {

  var type: String!
  var authorName: String!
  var authorURL: String!
  var providerURL: String!
  var providerDescription: String!
  var providerTitle: String!
  var width: Int!
  var height: Int!
  var thumbnailWidth: Int!
  var thumbnailHeight: Int!
  var thumbnailURL: NSURL!
  var html: String!

  // MARK: JSON
  init?(_ map: Map) {
    guard map.JSONDictionary.count > 0 else {
      return nil
    }
  }

  mutating func mapping(map: Map) {
    type <- map["type"]
    authorName <- map["oembed.author_name"]
    authorURL <- map["oembed.author_url"]
    providerURL <- map["oembed.provider_url"]
    providerDescription <- map["oembed.description"]
    providerTitle <- map["oembed.title"]
    width <- map["oembed.width"]
    height <- map["oembed.height"]
    thumbnailWidth <- map["oembed.thumbnail_width"]
    thumbnailHeight <- map["oembed.thumbnail_height"]
    html <- map["html"]
  }

}
