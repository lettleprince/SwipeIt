//
//  LinkActionBarView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit

class LinkActionBarView: UIView {

  // MARK: Inspectable Properties
  @IBInspectable var fontSize: CGFloat = UIFont.smallSystemFontSize() {
    didSet {
      commentsButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
      votesButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
  }

  @IBInspectable var imageInset: CGFloat = 10 {
    didSet {
      [commentsButton, votesButton, shareButton, downvoteButton, upvoteButton].forEach { button in
        button.imageEdgeInsets = UIEdgeInsets(top: imageInset, left: imageInset,
          bottom: imageInset, right: imageInset)
      }
    }
  }

  @IBInspectable var rightButtonWidth: CGFloat = 44 {
    didSet {
      [shareButton, downvoteButton, upvoteButton].forEach { button in
        button.snp_updateConstraints { make in
          make.width.equalTo(rightButtonWidth)
        }
      }
    }
  }

  // MARK: Views
  lazy var commentsButton: UIButton = {
    let commentsButton = UIButton()
    commentsButton.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: 0,
                                               bottom: self.imageInset, right: self.imageInset)
    commentsButton.setImage(UIImage(asset: .CommentsIcon), forState: .Normal)
    commentsButton.imageView?.contentMode = .ScaleAspectFit
    commentsButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.accentColor
      .bindTo(commentsButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    return commentsButton
  }()

  lazy var votesButton: UIButton = {
    let votesButton = UIButton()
    votesButton.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: 0,
                                               bottom: self.imageInset, right: self.imageInset)
    votesButton.setImage(UIImage(asset: .VotesIcon), forState: .Normal)
    votesButton.imageView?.contentMode = .ScaleAspectFit
    votesButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.accentColor
      .bindTo(votesButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    return votesButton
  }()

  lazy var shareButton: UIButton = {
    let shareButton = UIButton()
    shareButton.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: self.imageInset,
                                                bottom: self.imageInset, right: self.imageInset)
    shareButton.setImage(UIImage(asset: .ShareIcon), forState: .Normal)
    shareButton.imageView?.contentMode = .ScaleAspectFit
    Theming.sharedInstance.accentColor
      .bindTo(shareButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    return shareButton
  }()

  lazy var downvoteButton: UIButton = {
    let downvoteButton = UIButton()
    downvoteButton.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: self.imageInset,
                                                  bottom: self.imageInset, right: self.imageInset)
    downvoteButton.setImage(UIImage(asset: .DownvoteIcon), forState: .Normal)
    downvoteButton.imageView?.contentMode = .ScaleAspectFit
    Theming.sharedInstance.accentColor
      .bindTo(downvoteButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    return downvoteButton
  }()

  lazy var upvoteButton: UIButton = {
    let upvoteButton = UIButton()
    upvoteButton.imageEdgeInsets = UIEdgeInsets(top: self.imageInset, left: self.imageInset,
                                               bottom: self.imageInset, right: self.imageInset)
    upvoteButton.setImage(UIImage(asset: .UpvoteIcon), forState: .Normal)
    upvoteButton.imageView?.contentMode = .ScaleAspectFit
    Theming.sharedInstance.accentColor
      .bindTo(upvoteButton.rx_color)
      .addDisposableTo(self.rx_disposeBag)
    return upvoteButton
  }()

  // MARK: Private Views
  private lazy var rightStackView: UIStackView = {
    let views = [self.shareButton, self.downvoteButton, self.upvoteButton]
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.distribution = .EqualSpacing
    return stackView
  }()

  private lazy var leftStackView: UIStackView = {
    let views = [self.commentsButton, self.votesButton]
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.distribution = .EqualSpacing
    return stackView
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
    addSubview(leftStackView)
    addSubview(rightStackView)

    setupConstraints()
  }

  private func setupConstraints() {
    rightStackView.snp_makeConstraints { make in
      make.right.top.bottom.equalTo(self)
    }
    leftStackView.snp_makeConstraints { make in
      make.left.top.bottom.equalTo(self)
    }

    rightStackView.arrangedSubviews.forEach { view in
      view.snp_makeConstraints { make in
        make.width.equalTo(rightButtonWidth)
      }
    }

    [leftStackView.arrangedSubviews, rightStackView.arrangedSubviews].flatten()
      .forEach { view in
        view.snp_makeConstraints { make in
          make.height.equalTo(self)
        }
    }
  }
}
