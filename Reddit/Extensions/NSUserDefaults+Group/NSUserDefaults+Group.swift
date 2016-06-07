//
//  NSUserDefaults+Group.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension NSUserDefaults {

  private static let suitName = "group.vc.faber.Reddit"

  static var userDefaults: NSUserDefaults {
    return NSUserDefaults(suiteName: suitName) ?? .standardUserDefaults()
  }
}
