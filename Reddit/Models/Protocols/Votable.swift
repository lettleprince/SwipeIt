//
//  Votable.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Votable: Created {

  var ups: Int! { get set }
  var downs: Int! { get set }
  var vote: Vote! { get set }
  var score: Int! { get set }

  mutating func mappingVotable(map: Map)
}

extension Votable {

  mutating func mappingVotable(map: Map) {
    mappingCreated(map)
    ups <- map["data.ups"]
    downs <- map["data.downs"]
    vote <- (map["data.likes"], VoteTransform())
    score <- map["data.score"]
  }

}
