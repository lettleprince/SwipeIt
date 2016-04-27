//
//  Listing.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct LinkListing: Mappable, Listing {

  // MARK: LinkListing
  var before: String?
  var after: String?
  var links: [Link]?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingListing(map)
    links <- map["data.children"]
  }

}
