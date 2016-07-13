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

class LinkImageView: LinkView {

  private let imageContentView = LinkContentImageView()

  var imageView: AnimatedImageView {
    return imageContentView.imageView
  }

  var indicatorLabel: UILabel {
    return imageContentView.indicatorLabel
  }

  var overlayLabel: UILabel {
    return imageContentView.overlayLabel
  }

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

  func showOverlay(animated: Bool = false) {
    imageContentView.showOverlay(animated)
  }

  func hideOverlay(animated: Bool = false) {
    imageContentView.hideOverlay(animated)
  }
}

// MARK: Size
extension LinkImageView {

  class func heightForWidth(title: String, imageSize: CGSize, width: CGFloat) -> CGFloat {
    let linkViewHeight = heightForWidth(title, width: width)
    let ratio = imageSize.height / imageSize.width
    let imageHeight = width * ratio
    let heights = [linkViewHeight, imageHeight]
    return heights.reduce(0, combine: +)
  }
}
