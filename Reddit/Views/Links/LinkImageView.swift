//
//  LinkImageView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: Properties and Initializer
class LinkImageView: LinkView {

  // MARK: Private Properties
  private let imageContentView = LinkImageContentView()

  // MARK: Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    contentView = imageContentView
    contentView.snp_updateConstraints { make in
      make.left.equalTo(self)
      make.right.equalTo(self)
    }
  }

  // MARK: API
  var overlayText: String? {
    get {
      return imageContentView.overlayText
    }
    set {
      imageContentView.overlayText = newValue
    }
  }

  var indicatorText: String? {
    get {
      return imageContentView.indicatorText
    }
    set {
      imageContentView.indicatorText = newValue
    }
  }

  func setImageWithURL(imageURL: NSURL?, completion: ((UIImage?, NSURL?) -> Void)? = nil) {
    imageContentView.setImageWithURL(imageURL, completion: completion)
  }

  func playGIF() {
    imageContentView.playGIF()
  }

  func stopGIF() {
    imageContentView.stopGIF()
  }

  func setImageSize(size: CGSize) {
    imageContentView.setImageSize(size)
  }

  func showOverlay(animated: Bool = false) {
    imageContentView.showOverlay(animated)
  }

  func hideOverlay(animated: Bool = false) {
    imageContentView.hideOverlay(animated)
  }
}
