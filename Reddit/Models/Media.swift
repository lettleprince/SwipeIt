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

  // MARK: Media
  var type: String!
  var authorName: String!
  var authorURL: NSURL!
  var providerURL: NSURL!
  var providerName: String!
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
    authorURL <- (map["oembed.author_url"], EmptyURLTransform())
    providerURL <- (map["oembed.provider_url"], EmptyURLTransform())
    providerDescription <- map["oembed.description"]
    providerName <- map["oembed.provider_name"]
    providerTitle <- map["oembed.title"]
    width <- map["oembed.width"]
    height <- map["oembed.height"]
    thumbnailWidth <- map["oembed.thumbnail_width"]
    thumbnailHeight <- map["oembed.thumbnail_height"]
    thumbnailURL <- (map["oembed.thumbnail_url"], EmptyURLTransform())
    html <- map["oembed.html"]
  }

}
