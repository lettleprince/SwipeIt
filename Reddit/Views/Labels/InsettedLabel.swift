//
//  InsettedLabel.swift
//  Reddit
//
//  Created by Ivan Bruel on 11/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class InsettedLabel: UILabel {

  var insets: UIEdgeInsets = UIEdgeInsetsZero {
    didSet {
      invalidateIntrinsicContentSize()
    }
  }

  override func intrinsicContentSize() -> CGSize {
    var intrinsicContentSize = super.intrinsicContentSize()
    intrinsicContentSize.height += insets.top + insets.bottom
    intrinsicContentSize.width += insets.left + insets.right
    return intrinsicContentSize
  }
}
