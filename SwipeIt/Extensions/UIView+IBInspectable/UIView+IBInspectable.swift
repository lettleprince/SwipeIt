//
//  UIView.swift
//  Reddit
//
//  Created by Ivan Bruel on 19/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension UIView {

  // MARK - IBInspectable
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable
  var borderColor: UIColor? {
    get {
      return layer.borderColor.map { UIColor(CGColor: $0) }
    }
    set {
      layer.borderColor = newValue?.CGColor
    }
  }

  @IBInspectable
  var shadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = newValue
    }
  }

  /// https://openradar.appspot.com/25935307
  @IBInspectable
  var negativeShadowOffset: CGSize {
    get {
      return layer.shadowOffset
    }
    set {
      layer.shadowOffset = CGSize(width: -newValue.width, height: -newValue.height)
    }
  }

  @IBInspectable
  var shadowColor: UIColor? {
    get {
      return layer.shadowColor.map { UIColor(CGColor: $0) }
    }
    set {
      layer.shadowColor = newValue?.CGColor
    }
  }

  @IBInspectable
  var shadowOpacity: Float {
    get {
      return layer.shadowOpacity
    }
    set {
      layer.shadowOpacity = newValue
    }
  }

  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowRadius = newValue
    }
  }

  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
}
