//
//  QueryReader.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class QueryReader {

  class func queryParametersFromString(string: String) -> [String: AnyObject] {

    let components = string.componentsSeparatedByString("&")
    let json = components.map { $0.componentsSeparatedByString("=") }
      .reduce([:]) { (dict, components) -> [String: AnyObject] in
        var dict = dict
        if components.count == 2 {
          dict[components[0]] = components[1]
        }
        return dict
    }
    return json
  }

}
