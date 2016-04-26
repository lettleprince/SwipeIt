//
//  Listing.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct Listing: Mappable {

  var after: String?
  var links: [Link]?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    after <- map["data.after"]
    links <- map["data.children"]
  }

}
