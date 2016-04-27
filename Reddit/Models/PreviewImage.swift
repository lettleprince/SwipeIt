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
  var source: Image!
  var resolutions: [Image]!
  var nsfwSource: Image?
  var nsfwResolutions: [Image]?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    identifier <- map["id"]
    source <- map["source"]
    resolutions <- map["resolutions"]
    nsfwSource <- map["variants.nsfw.source"]
    nsfwResolutions <- map["variants.nsfw.resolutions"]
  }

}
