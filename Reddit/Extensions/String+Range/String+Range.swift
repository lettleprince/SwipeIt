//
//  String+Range.swift
//  Reddit
//
//  Created by Ivan Bruel on 15/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension String {

  func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
    let fromUTF16 = utf16.startIndex.advancedBy(nsRange.location)
    let toUTF16 = fromUTF16.advancedBy(nsRange.length)

    if let from = String.Index(fromUTF16, within: self),
      to = String.Index(toUTF16, within: self) {
      return from..<to
    }
    return nil
  }
}
