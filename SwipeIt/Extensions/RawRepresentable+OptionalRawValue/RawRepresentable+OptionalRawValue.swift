//
//  EnumTransformable+OptionalRawValue.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

extension RawRepresentable {

  /**
   Failable initializer for RawRepresentables with optional raw values

   :param: optionalRawValue An optional raw value.

   :returns: The RawRepresentable value or nil.
   */
   init?(optionalRawValue: RawValue?) {

    guard let rawValue = optionalRawValue, value = Self(rawValue: rawValue) else { return nil }

    self = value
  }
}
