//
//  Image.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Image: Mappable {

  // MARK: Image
  var url: NSURL!
  var width: Int!
  var height: Int!

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    url <- (map["url"], EmptyURLTransform())
    width <- map["width"]
    height <- map["height"]
  }

}
