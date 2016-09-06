//
//  CircleButton.swift
//  Reddit
//
//  Created by Ivan Bruel on 18/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setImage(imageForState(.Normal)?.tint(.whiteColor()), forState: .Highlighted)
    setImage(imageForState(.Normal)?.tint(UIColor(named: .Gray)), forState: .Disabled)

  }

  override func setImage(image: UIImage?, forState state: UIControlState) {
    if state == .Normal {
      setImage(image?.tint(.whiteColor()), forState: .Highlighted)
      setImage(image?.tint(UIColor(named: .Gray)), forState: .Disabled)
    }
    super.setImage(image, forState: state)
  }

  // MARK: - Lifecycle
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(bounds.size.height, bounds.size.width) / 2
  }

  override var highlighted: Bool {
    didSet {
      UIView.animateWithDuration(0.15) {
        if self.highlighted {
          self.backgroundColor = self.tintColor
        } else {
          self.backgroundColor = .whiteColor()
        }
      }
    }
  }
}
