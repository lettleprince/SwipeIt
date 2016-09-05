//
//  UIImageViewTopAligned.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
public class UIImageViewTopAligned: UIImageView {

  public override var image: UIImage? {
    set {
      realImageView.image = newValue
      setNeedsLayout()
    }
    get {
      return realImageView.image
    }
  }

  public override var highlighted: Bool {
    set {
      super.highlighted = newValue
      layer.contents = nil
    }
    get {
      return super.highlighted
    }
  }

  /**
   The inner image view.

   It should be used only when necessary.
   Available to keep compatibility with original `UIImageViewAligned`.
   */
  private let realImageView: AnimatedImageView = AnimatedImageView(frame: .zero)

  // MARK: - Initializers
  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  public override init(image: UIImage?) {
    super.init(image: image)
    commonInit()
  }

  public override init(image: UIImage?, highlightedImage: UIImage?) {
    super.init(image: image, highlightedImage: highlightedImage)
    commonInit()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    realImageView.autoPlayAnimatedImage = false
    realImageView.kf_showIndicatorWhenLoading = true
    // Better performance while scrolling
    realImageView.framePreloadCount = 1
    realImageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    realImageView.contentMode = contentMode
    addSubview(realImageView)

    if super.image != nil {
      swap(&image, &super.image)
    }
  }

  private func updateLayout() {
    guard let image = realImageView.image else {
      return
    }
    let realSize = realContentSize()

    var realFrame = CGRect(x: (bounds.size.width - realSize.width) / 2.0,
                           y: (bounds.size.height - realSize.height) / 2.0,
                           width: realSize.width,
                           height: realSize.height)

    let size = bounds.size
    let scaleX = size.width / image.size.width
    let scaleY = size.height / image.size.height

    let scale = max(scaleX, scaleY)

    if scale < 1.0 {
      realFrame.origin.y = 0.0
    }
    realImageView.frame = realFrame.integral

    // Make sure we clear the contents of this container layer, since it refreshes
    // from the image property once in a while.
    layer.contents = nil
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    updateLayout()
  }

  // MARK: - Private methods
  private func realContentSize() -> CGSize {
    var size = bounds.size

    guard let image = realImageView.image else {
      return size
    }

    let scaleX = size.width / image.size.width
    let scaleY = size.height / image.size.height

    let scale = max(scaleX, scaleY)

    size = CGSize(width: image.size.width * scale,
                  height: image.size.height * scale)
    return size
  }

  // MARK: - UIImageView overloads
  public override func didMoveToSuperview() {
    super.didMoveToSuperview()
    layer.contents = nil
  }

  public override func didMoveToWindow() {
    super.didMoveToWindow()
    layer.contents = nil
  }
}
