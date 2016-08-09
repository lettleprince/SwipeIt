//
//  BorderedButton.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

@IBDesignable class BorderedButton: UIButton {

  // MARK: - IBInspectable Properties
  @IBInspectable var cornerRadius: CGFloat = 4 {
    didSet {
      layer.cornerRadius = cornerRadius
    }
  }

  @IBInspectable var borderWidth: CGFloat = 1 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }

  @IBInspectable var spacing: CGFloat = 4

  override var tintColor: UIColor! {
    didSet {
      layer.borderColor = tintColor.CGColor
      setTitleColor(tintColor, forState: .Normal)
    }
  }

  // MARK: - Initializers
  init() {
    super.init(frame: CGRect.zero)
    commonInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    opaque = false
    backgroundColor = .clearColor()
    cornerRadius = 4
    borderWidth = 1
    clipsToBounds = true
    setTitleColor(tintColor, forState: .Normal)
    setTitleColor(.whiteColor(), forState: .Highlighted)
  }

  override var highlighted: Bool {
    didSet {
      backgroundColor = highlighted ? tintColor : .clearColor()
    }
  }

  override func intrinsicContentSize() -> CGSize {
    guard let titleSize = titleLabel?.intrinsicContentSize() else {
      return super.intrinsicContentSize()
    }
    return CGSize(width: titleSize.width + spacing * 4, height: titleSize.height + spacing * 2)
  }

}
