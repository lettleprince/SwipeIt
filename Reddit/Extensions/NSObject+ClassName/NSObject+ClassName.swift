//
//  NSObject+ClassName.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension NSObject {

  /// Returns the className for the Class, removing the 'Reddit.' prefix.
  static var className: String {
    return NSStringFromClass(self).componentsSeparatedByString(".").last ?? NSStringFromClass(self)
  }

}
