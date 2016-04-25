//
//  Created.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import ObjectMapper

protocol Created {

  var created: NSDate! { get set }

  mutating func mappingCreated(map: Map)

}

extension Created {

  mutating func mappingCreated(map: Map) {
    created <- (map["data.created_utc"], EpochDateTransform())
  }

}
