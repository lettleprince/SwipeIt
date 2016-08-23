//
//  LinkImageCardView.swift
//  Reddit
//
//  Created by Ivan Bruel on 19/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Kingfisher

@IBDesignable
class LinkImageCardView: LinkCardView {

  override var viewModel: LinkItemViewModel? {
    didSet {
      guard let imageViewModel = viewModel as? LinkItemImageViewModel else { return }
      imageView.kf_setImageWithURL(imageViewModel.imageURL)
    }
  }

  // MARK: - Views
  private lazy var imageView: AnimatedImageView = {
    let imageView = AnimatedImageView()
    imageView.autoPlayAnimatedImage = false
    imageView.contentMode = .ScaleAspectFill
    // Better performance while scrolling
    imageView.framePreloadCount = 1
    imageView.clipsToBounds = true
    return imageView
  }()

  // MARK - Initializers
  override init() {
    super.init(frame: .zero)
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
    contentView = imageView
  }

  override func didAppear() {
    super.didAppear()
    imageView.startAnimating()
  }

  override func didDisappear() {
    super.didDisappear()
    imageView.stopAnimating()
  }
}
