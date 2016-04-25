//
//  Subreddit.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

struct Subreddit {

  let name: String
  var listings: [Listing]

  init(name: String) {
    self.name = name
    self.listings = []
  }

}
