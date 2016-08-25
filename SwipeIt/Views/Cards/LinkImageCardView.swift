//
//  LinkImageCardView.swift
//  Reddit
//
//  Created by Ivan Bruel on 19/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Async
import Kingfisher
import GPUImage2

@IBDesignable
class LinkImageCardView: LinkCardView {

  override var viewModel: LinkItemViewModel? {
    didSet {
      guard let imageViewModel = viewModel as? LinkItemImageViewModel else { return }
      imageView
        .kf_setImageWithURL(imageViewModel.imageURL, optionsInfo: [.Transition(.Fade(0.15))]) {
          [weak self] (image, _, _, imageURL) in
          guard let image = image, backgroundImageView = self?.backgroundImageView
            where imageURL == imageViewModel.imageURL else {
            self?.backgroundImageView.image = nil
            return
          }
          LinkImageCardView.blurImage(image, imageView: backgroundImageView)
      }
    }
  }

  // MARK: - Views
  private lazy var imageContentView: UIView = {
    let view = UIView()
    view.backgroundColor = .clearColor()
    view.clipsToBounds = false
    view.addSubview(self.backgroundImageView)
    view.addSubview(self.imageView)
    return view
  }()

  private lazy var imageView: AnimatedImageView = {
    let imageView = AnimatedImageView()
    imageView.autoPlayAnimatedImage = false
    imageView.contentMode = .ScaleAspectFit
    // Better performance while scrolling
    imageView.framePreloadCount = 1
    imageView.clipsToBounds = true
    return imageView
  }()

  private lazy var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
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
    contentView = imageContentView
    setupConstraints()
  }

  private func setupConstraints() {
    imageView.snp_makeConstraints { make in
      make.edges.equalTo(imageContentView)
    }

    backgroundImageView.snp_makeConstraints { make in
      make.edges.equalTo(imageContentView)
    }
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

extension LinkImageCardView {

  /**
   Blurs an image in a background thread and then sets the image to the imageView in the main thread

   - parameter image:     The image to be blurred.
   - parameter imageView: The imageView in which to set the blurred image.
   */
  private static func blurImage(image: UIImage, imageView: UIImageView) {
    Async.background {
      let blurFilter = iOSBlur()
      let brightnessFilter = BrightnessAdjustment()
      brightnessFilter.brightness = -0.2
      let blurredImage = image.filterWithPipeline { (input, output) in
        input --> blurFilter --> brightnessFilter --> output
      }
      Async.main {
        imageView.image = blurredImage
      }
    }
  }
}
