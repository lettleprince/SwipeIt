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
    kf_showIndicatorWhenLoading = true
    // Better performance while scrolling
    realImageView.framePreloadCount = 1
    realImageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    realImageView.contentMode = contentMode
    realImageView.frame = bounds
    addSubview(realImageView)

    if super.image != nil {
      swap(&image, &super.image)
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    updateLayout()
  }

  public override func startAnimating() {
    super.startAnimating()
    realImageView.startAnimating()
  }

  public override func stopAnimating() {
    super.stopAnimating()
    realImageView.stopAnimating()
  }

  // MARK: - Private methods
  private func updateLayout() {
    guard let _ = image else {
      realImageView.frame = bounds
      return
    }

    let realSize = realContentSize()

    var realFrame = CGRect(x: (bounds.size.width - realSize.width) / 2.0,
                           y: (bounds.size.height - realSize.height) / 2.0,
                           width: realSize.width,
                           height: realSize.height)

    if realSize.height > bounds.size.height {
      realFrame.origin.y = 0.0
    }
    realImageView.frame = realFrame.integral

    // Make sure we clear the contents of this container layer, since it refreshes
    // from the image property once in a while.
    layer.contents = nil
  }

  private func realContentSize() -> CGSize {
    let size = bounds.size

    guard let image = realImageView.image else {
      return size
    }

    let scaleX = size.width / image.size.width
    let scaleY = size.height / image.size.height

    let scale = min(scaleX, scaleY)
    let height = image.size.height * scale

    if height < size.height {
      return CGSize(width: image.size.width * scale, height: height)
    } else {
      let maxScale = max(scaleX, scaleY)
      return CGSize(width: image.size.width * maxScale,
                    height: image.size.height * maxScale)
    }
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
