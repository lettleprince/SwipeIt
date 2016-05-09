//
//  String+FirstLetter.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension String {

  var firstLetter: String {
    if let firstCharacter: UnicodeScalar = unicodeScalars.first {
      if NSCharacterSet.decimalDigitCharacterSet().longCharacterIsMember(firstCharacter.value) {
        return "#"
      }
      return String(firstCharacter).uppercaseString
    }
    return ""
  }

}
