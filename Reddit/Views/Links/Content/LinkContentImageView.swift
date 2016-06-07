//
//  LinkContentImageView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit
import Async

class LinkContentImageView: UIView {

  // MARK: IBInspectable
  @IBInspectable var spacing: CGFloat = 8 {
    didSet {
      indicatorLabel.snp_updateConstraints { make in
        make.right.equalTo(self).inset(spacing)
        make.top.equalTo(self).offset(spacing)
      }
    }
  }

  @IBInspectable var overlayLabelFontSize: CGFloat = UIFont.buttonFontSize() {
    didSet {
      overlayLabel.font = UIFont.systemFontOfSize(overlayLabelFontSize)
    }
  }

  @IBInspectable var indicatorLabelFontSize: CGFloat = UIFont.smallSystemFontSize() {
    didSet {
      indicatorLabel.font = UIFont.systemFontOfSize(indicatorLabelFontSize)
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

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit
    return imageView
  }()

  lazy var indicatorLabel: UILabel = {
    let indicatorLabel = UILabel()
    indicatorLabel.font = UIFont.systemFontOfSize(self.indicatorLabelFontSize)
    indicatorLabel.backgroundColor = .whiteColor()
    indicatorLabel.textColor = .clearColor()
    return indicatorLabel
  }()

  lazy var overlayView: UIView = {
    let overlayView = UIView()
    let tapGestureRecognizer =
      UITapGestureRecognizer(target: self, action: #selector(LinkContentImageView.overlayTapped))
    overlayView.addGestureRecognizer(tapGestureRecognizer)
    Theming.sharedInstance.backgroundColor
      .bindTo(overlayView.rx_backgroundColor)
      .addDisposableTo(self.rx_disposeBag)
    overlayView.addSubview(self.overlayLabel)
    return overlayView
  }()

  lazy var overlayLabel: UILabel = {
    let overlayLabel = UILabel()
    overlayLabel.textAlignment = .Center
    overlayLabel.font = UIFont.systemFontOfSize(self.overlayLabelFontSize)
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    clipsToBounds = true
    addSubview(imageView)
    addSubview(indicatorLabel)
    addSubview(overlayView)

    setupConstraints()
  }

  private func setupConstraints() {
    imageView.snp_makeConstraints { make in
      make.edges.equalTo(self)
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

  func showOverlay(animated: Bool) {
    let animations = {
      self.overlayView.alpha = 1
    }
    if animated {
      UIView.animateWithDuration(0.25, animations: animations)
    } else {
      animations()
    }
  }

  func overlayTapped() {
    hideOverlay(true)
  }

  func hideOverlay(animated: Bool) {
    let animations = {
      self.overlayView.alpha = 0
    }
    if animated {
      UIView.animateWithDuration(0.25, animations: animations)
    } else {
      animations()
    }
  }
}
