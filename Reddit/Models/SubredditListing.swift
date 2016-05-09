//
//  SubredditListing.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

struct SubredditListing: Mappable, Listing {

  // MARK: Listing
  var before: String?
  var after: String?

  // MARK: SubredditListing
  var subreddits: [Subreddit]?

  // MARK: JSON
  init?(_ map: Map) {
    // Fail if no data is found
    guard let _ = map.JSONDictionary["data"] else { return nil }
  }

  mutating func mapping(map: Map) {
    mappingListing(map)
    subreddits <- map["data.children"]
  }

}
