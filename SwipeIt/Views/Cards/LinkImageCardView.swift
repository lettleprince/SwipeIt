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

  private static let fadeAnimationDuration: NSTimeInterval = 0.15

  override var viewModel: LinkItemViewModel? {
    didSet {
      guard let imageViewModel = viewModel as? LinkItemImageViewModel else { return }
      let options: [KingfisherOptionsInfoItem] =
        [.Transition(.Fade(LinkImageCardView.fadeAnimationDuration))]
      imageView
        .kf_setImageWithURL(imageViewModel.imageURL, optionsInfo: options) {
          [weak self] (image, _, _, imageURL) in
          guard let image = image, backgroundImageView = self?.backgroundImageView
            where imageURL == imageViewModel.imageURL else {
              self?.backgroundImageView.image = nil
              return
          }
          LinkImageCardView.blurImage(image, into: backgroundImageView)
      }
    }
  }

  // MARK: - Views
  private lazy var imageContentView: UIView = self.createImageContentView()
  private lazy var imageView: AnimatedImageView = self.createImageView()
  private lazy var backgroundImageView: UIImageView = self.createBackgroundImageView()
  
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
   Blurs the provided image and sets it in the image view.
   In order to save memory this function also scales down the image before processing.
   In the end it will fade in the image into the image view.

   - parameter image:     The image to be blurred.
   - parameter imageView: The imageView in which to set the blurred image.
   */
  private static func blurImage(image: UIImage, into imageView: UIImageView) {
    Async.background {
      let scaledImage = resizeImage(image, imageView: imageView)
      let blurFilter = iOSBlur()
      let brightnessFilter = BrightnessAdjustment()
      brightnessFilter.brightness = -0.2
      let blurredImage = scaledImage.filterWithPipeline { (input, output) in
        input --> blurFilter --> brightnessFilter --> output
      }
      Async.main {
        UIView.transitionWithView(imageView, duration: fadeAnimationDuration,
          options: .TransitionCrossDissolve, animations: {
            imageView.image = blurredImage
          }, completion: nil)
      }
    }
  }

  private static func resizeImage(image: UIImage, imageView: UIImageView) -> UIImage {
    let screenWidth = UIScreen.mainScreen().bounds.width
    let size = imageView.bounds.size != .zero ? imageView.bounds.size :
      CGSize(width: screenWidth, height: screenWidth)
    return image.scaleToSizeWithAspectFill(size)
  }

  private func createImageContentView() -> UIView {
    let view = UIView()
    view.backgroundColor = .clearColor()
    view.clipsToBounds = false
    view.addSubview(self.backgroundImageView)
    view.addSubview(self.imageView)
    return view
  }

  private func createImageView() -> AnimatedImageView {
    let imageView = AnimatedImageView()
    imageView.autoPlayAnimatedImage = false
    imageView.contentMode = .ScaleAspectFit
    imageView.kf_showIndicatorWhenLoading = true
    // Better performance while scrolling
    imageView.framePreloadCount = 1
    imageView.clipsToBounds = true
    return imageView
  }

  private func createBackgroundImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }
}
