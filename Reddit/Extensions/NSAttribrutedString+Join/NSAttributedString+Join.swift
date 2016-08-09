//
//  NSAttributedString+Join.swift
//  Reddit
//
//  Created by Ivan Bruel on 05/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element: NSAttributedString {
  func joinWithSeparator(separator: NSAttributedString) -> NSAttributedString {
    var isFirst = true
    return self.reduce(NSMutableAttributedString()) {
      (r, e) in
      if isFirst {
        isFirst = false
      } else {
        r.appendAttributedString(separator)
      }
      r.appendAttributedString(e)
      return r
    }
  }

  func joinWithSeparator(separator: String) -> NSAttributedString {
    return joinWithSeparator(NSAttributedString(string: separator))
  }
}
