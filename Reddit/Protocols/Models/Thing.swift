//
//  Thing.swift
//  Reddit
//
//  Created by Ivan Bruel on 07/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Thing {

  var identifier: String! { get set }
  var name: String! { get set }
  var kind: String! { get set }

  mutating func mappingThing(map: Map)

}

extension Thing {

  mutating func mappingThing(map: Map) {
    identifier <- map["data.id"]
    name <- map["data.name"]
    kind <- map["kind"]
  }

}
