//
//  CGSize+Ratio.swift
//  Reddit
//
//  Created by Ivan Bruel on 01/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension CGSize {

  /// Returns the image ratio (w:h)
  var ratio: CGFloat {
    return width / height
  }
}
