//
//  MultiredditListing.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct MultiredditListing: Mappable, Listing {

  // MARK: Listing
  var before: String?
  var after: String?

  // MARK: MultiredditListing
  var multireddits: [Multireddit]?

  // MARK: JSON
  init?(_ map: Map) { }

  mutating func mapping(map: Map) {
    mappingListing(map)
    multireddits <- map["data.children"]
  }

}
