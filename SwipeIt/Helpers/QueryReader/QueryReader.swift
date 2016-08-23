//
//  QueryReader.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class QueryReader {

  class func queryParametersFromString(URLString: String) -> [String: String] {
    guard let URLComponents = NSURLComponents(string: URLString) else {
      return [:]
    }
    return URLComponents.queryItems?.reduce([:]) { (dictionary, queryItem) -> [String: String] in
      var dictionary = dictionary
      if let value = queryItem.value {
        dictionary[queryItem.name] = value
      }
      return dictionary
    } ?? [:]
  }

}
