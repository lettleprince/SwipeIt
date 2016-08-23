//
//  CircleView.swift
//  Reddit
//
//  Created by Ivan Bruel on 19/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(bounds.size.height, bounds.size.width) / 2
  }
}
