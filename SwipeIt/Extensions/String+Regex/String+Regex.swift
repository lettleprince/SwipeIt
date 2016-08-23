//
//  String+Regex.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension String {

  func matchesWithRegex(pattern: String) -> Bool {
    return rangeOfString(pattern, options: .RegularExpressionSearch) != nil
  }

  func regexMatches(pattern: String) -> [NSTextCheckingResult] {
    let regex: NSRegularExpression
    do {
      regex = try NSRegularExpression(pattern: pattern, options: [])
    } catch {
      return []
    }

    return regex.matchesInString(self, options: [],
                                        range: NSRange(location: 0, length: self.utf16.count))
  }
}
