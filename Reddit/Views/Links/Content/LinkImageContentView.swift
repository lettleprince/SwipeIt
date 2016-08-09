//
//  LinkImageContentView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit
import Async
import Kingfisher
import RxColor

// MARK: Properties and Initializer
class LinkImageContentView: UIView {

  private static let minimumProgress: Float = 0.01

  // MARK: IBInspectable
  @IBInspectable var spacing: CGFloat = 8 {
    didSet {
      indicatorLabel.insets = UIEdgeInsets(top: spacing / 4, left: spacing / 2,
                                           bottom: spacing / 4, right: spacing / 2)
      indicatorLabel.snp_updateConstraints { make in
        make.right.equalTo(self).inset(spacing)
        make.top.equalTo(self).offset(spacing)
      }
    }
  }

  @IBInspectable var overlayCircleRadius: CGFloat = 44 {
    didSet {
      overlayLabel.snp_updateConstraints { make in
        make.height.width.equalTo(overlayCircleRadius * 2)
      }
    }
  }

  @IBInspectable var overlayBorderWidth: CGFloat = 1 {
    didSet {
      overlayLabel.layer.borderWidth = overlayBorderWidth
    }
  }

  // MARK: Inner Views
  private lazy var imageView: AnimatedImageView = {
    let imageView = AnimatedImageView()
    imageView.contentMode = .ScaleAspectFit
    // Better performance while scrolling
    imageView.framePreloadCount = 1
    return imageView
  }()

  private lazy var loaderView: CircularLoaderView = {
    let loaderView = CircularLoaderView()
    loaderView.emptyLineWidth = 1 / UIScreen.mainScreen().scale
    loaderView.progressLineWidth = 2
    Theming.sharedInstance.accentColor.subscribeNext { accentColor in
      loaderView.progressLineColor = accentColor
      loaderView.emptyLineColor = accentColor
      }.addDisposableTo(self.rx_disposeBag)
    return loaderView
  }()

  private lazy var retryButton: BorderedButton = {
    let retryButton = BorderedButton(type: .Custom)
    retryButton.borderWidth = 1 / UIScreen.mainScreen().scale
    retryButton.titleLabel?.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    retryButton.setTitle(tr(.Retry), forState: .Normal)
    retryButton.alpha = 0
    Theming.sharedInstance.accentColor
      .bindTo(retryButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    retryButton.addTarget(self, action: #selector(LinkImageContentView.retryClicked),
                          forControlEvents: .TouchUpInside)
    return retryButton
  }()

  private lazy var indicatorLabel: InsettedLabel = {
    let indicatorLabel = InsettedLabel()
    indicatorLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
    indicatorLabel.layer.cornerRadius = 4
    indicatorLabel.layer.masksToBounds = true
    indicatorLabel.textAlignment = .Center
    indicatorLabel.insets = UIEdgeInsets(top: self.spacing / 4, left: self.spacing / 2,
                                         bottom: self.spacing / 4, right: self.spacing / 2)
    Theming.sharedInstance.backgroundColor
      .bindTo(indicatorLabel.rx_backgroundColor)
      .addDisposableTo(self.rx_disposeBag)
    Theming.sharedInstance.secondaryTextColor
      .bindTo(indicatorLabel.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return indicatorLabel
  }()

  private lazy var overlayView: UIView = {
    let overlayView = UIView()
    let tapGestureRecognizer =
      UITapGestureRecognizer(target: self, action: #selector(LinkImageContentView.overlayTapped))
    overlayView.addGestureRecognizer(tapGestureRecognizer)
    Theming.sharedInstance.backgroundColor
      .bindTo(overlayView.rx_backgroundColor)
      .addDisposableTo(self.rx_disposeBag)
    overlayView.addSubview(self.overlayLabel)
    return overlayView
  }()

  private lazy var overlayLabel: UILabel = {
    let overlayLabel = UILabel()
    overlayLabel.textAlignment = .Center
    overlayLabel.font = UIFont.systemFontOfSize(UIFont.buttonFontSize())
    overlayLabel.adjustsFontSizeToFitWidth = true
    overlayLabel.minimumScaleFactor = 0.5
    overlayLabel.layer.borderWidth = self.overlayBorderWidth
    Theming.sharedInstance.secondaryTextColor
      .subscribeNext { color in
        overlayLabel.textColor = color
        overlayLabel.layer.borderColor = color.CGColor
      }.addDisposableTo(self.rx_disposeBag)
    return overlayLabel
  }()

  private var heightConstraint: Constraint? = nil
  private var imageURL: NSURL? = nil
  private var imageLoadingCompletion: ((UIImage?, NSURL?) -> Void)? = nil

  // MARK: Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: Setup
  private func setup() {
    clipsToBounds = true
    addSubview(imageView)
    addSubview(loaderView)
    addSubview(retryButton)
    addSubview(indicatorLabel)
    addSubview(overlayView)

    setupConstraints()
  }

  private func setupConstraints() {
    imageView.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }

    loaderView.snp_makeConstraints { make in
      make.center.equalTo(self)
      make.height.width.equalTo(overlayCircleRadius / 2)
    }

    retryButton.snp_makeConstraints { make in
      make.center.equalTo(self)
      make.height.equalTo(overlayCircleRadius / 2)
    }

    indicatorLabel.snp_makeConstraints { make in
      make.right.equalTo(self).inset(spacing)
      make.top.equalTo(self).offset(spacing)
    }

    overlayView.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }

    overlayLabel.snp_makeConstraints { make in
      make.height.width.equalTo(overlayCircleRadius * 2)
      make.center.equalTo(overlayView)
    }
  }

  override func layoutSubviews() {
    overlayLabel.layer.cornerRadius = overlayLabel.bounds.width / 2
  }

  // MARK: API
  var overlayText: String? {
    get {
      return overlayLabel.text
    }
    set {
      overlayLabel.text = newValue
      if newValue != nil {
        imageView.autoPlayAnimatedImage = false
        showOverlay()
      } else {
        imageView.autoPlayAnimatedImage = Globals.autoPlayGIF
        hideOverlay()
      }
    }
  }

  var indicatorText: String? {
    get {
      return indicatorLabel.text
    }
    set {
      indicatorLabel.text = newValue
      indicatorLabel.hidden = newValue == nil
    }
  }

  func setImageWithURL(imageURL: NSURL?, completion: ((UIImage?, NSURL?) -> Void)? = nil) {
    retryButton.alpha = 0
    self.imageURL = imageURL
    self.imageLoadingCompletion = completion
    setProgress(0, animated: false)
    imageView.kf_setImageWithURL(imageURL, optionsInfo: [.Transition(.Fade(0.25))],
                                 progressBlock: { [weak self] (receivedSize, totalSize) in
                                  self?.setProgress(Float(receivedSize) / Float(totalSize))
      }, completionHandler: { [weak self] (image, error, _, imageURL) in
        self?.setProgress(1)
        self?.handleError(error)
        completion?(image, imageURL)
      })
  }

  private func setProgress(progress: Float, animated: Bool = true) {
    var presentationProgress = max(LinkImageContentView.minimumProgress, progress)

    if presentationProgress < loaderView.progress && progress != 0 {
      presentationProgress = loaderView.progress
    }

    loaderView.setProgress(presentationProgress, animated: animated)
    switch presentationProgress {
    case 0..<1:
      loaderView.alpha = 1
    case 1:
      loaderView.alpha = 0
    default:
      break
    }
  }

  private func handleError(error: NSError?) {
    guard let _ = error else { return }
    retryButton.alpha = 1
  }

  func retryClicked() {
    setImageWithURL(imageURL, completion: imageLoadingCompletion)
  }

  func playGIF() {
    imageView.startAnimating()
  }

  func stopGIF() {
    imageView.stopAnimating()
  }

  func setImageSize(size: CGSize) {
    heightConstraint?.uninstall()
    imageView.snp_updateConstraints { make in
      heightConstraint = make.height.equalTo(imageView.snp_width)
        .dividedBy(size.ratio).priority(999).constraint
    }
  }

  // Hides overlay upon a tap on the overlay
  func overlayTapped() {
    hideOverlay(true) { _ in
      self.imageView.startAnimating()
    }
  }

  func showOverlay(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
    animateOverlay(true, animated: animated, completion: completion)
  }

  func hideOverlay(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
    animateOverlay(false, animated: animated, completion: completion)
  }

  private func animateOverlay(show: Bool, animated: Bool, completion: ((Bool) -> Void)?) {
    UIView.animateWithDuration(0.25, animations: {
      self.overlayView.alpha = show ? 1 : 0
      }, completion: completion)
  }
}

// MARK: Helpers
extension LinkImageContentView {

  class func heightForWidth(imageSize: CGSize, width: CGFloat) -> CGFloat {
    let ratio = imageSize.height / imageSize.width
    let imageHeight = width * ratio
    return imageHeight
  }
}
