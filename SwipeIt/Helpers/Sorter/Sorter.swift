//
//  Sorter.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class Sorter {

  // Numbers should always come first
  class func alphabetSort(firstLetter: String, secondLetter: String) -> Bool {
    if firstLetter == "#" {
      return true
    } else if secondLetter == "#" {
      return false
    }
    return firstLetter < secondLetter
  }
}
