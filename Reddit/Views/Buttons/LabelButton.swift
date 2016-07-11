//
//  LabelButton.swift
//  Reddit
//
//  Created by Ivan Bruel on 11/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class LabelButton: UIButton {

  override func intrinsicContentSize() -> CGSize {
    return titleLabel?.intrinsicContentSize() ?? super.intrinsicContentSize()
  }
}
