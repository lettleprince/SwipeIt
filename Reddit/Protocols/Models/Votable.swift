//
//  Votable.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Votable {

  var ups: Int! { get set }
  var downs: Int! { get set }
  var likes: Likes! { get set }
  var score: Int! { get set }

  mutating func mappingVotable(map: Map)
}

extension Votable {

  mutating func mappingVotable(map: Map) {
    ups <- map["data.ups"]
    downs <- map["data.downs"]
    likes <- (map["data.likes"], LikesTransform())
    score <- map["data.score"]
  }

}
