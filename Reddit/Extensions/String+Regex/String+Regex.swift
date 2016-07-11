//
//  String+Regex.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension String {

  func matchesWithRegex(regex: String) -> Bool {
    return rangeOfString(regex, options: .RegularExpressionSearch) != nil
  }
}
