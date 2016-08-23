//
//  PreviewImage.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct PreviewImage: Mappable {

  // MARK: PreviewImage
  var identifier: String!
  var source: ImageSource!
  var resolutions: [ImageSource]!
  var gifSource: ImageSource?
  var gifResolutions: [ImageSource]?
  var mp4Source: ImageSource?
  var mp4Resolutions: [ImageSource]?
  var nsfwSource: ImageSource?
  var nsfwResolutions: [ImageSource]?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    identifier <- map["id"]
    source <- map["source"]
    resolutions <- map["resolutions"]
    nsfwSource <- map["variants.nsfw.source"]
    nsfwResolutions <- map["variants.nsfw.resolutions"]
    gifSource <- map["variants.gif.source"]
    gifResolutions <- map["variants.gif.resolutions"]
    mp4Source <- map["variants.mp4.source"]
    mp4Resolutions <- map["variants.mp4.resolutions"]
  }
}
