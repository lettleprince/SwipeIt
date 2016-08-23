//
//  Listing.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Listing {

  var before: String? { get set }
  var after: String? { get set }

  mutating func mappingListing(map: Map)

}

extension Listing {

  mutating func mappingListing(map: Map) {
    before <- map["data.before"]
    after <- map["data.after"]
  }

}
