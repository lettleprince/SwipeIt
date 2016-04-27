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
  var voted: Voted! { get set }
  var score: Int! { get set }

  var upvoted: Bool { get }
  var downvoted: Bool { get }

  mutating func mappingVotable(map: Map)
}

extension Votable {

  var upvoted: Bool {
    return voted == .Upvoted
  }

  var downvoted: Bool {
    return voted == .Downvoted
  }

  mutating func mappingVotable(map: Map) {
    mappingCreated(map)
    ups <- map["data.ups"]
    downs <- map["data.downs"]
    voted <- (map["data.likes"], VotedTransform())
    score <- map["data.score"]
  }

}
