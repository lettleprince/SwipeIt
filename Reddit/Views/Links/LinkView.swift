//
//  LinkView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

// MARK: Properties and Initializers
@IBDesignable class LinkView: UIView {

  // MARK: Constants
  private static let actionBarViewHeight: CGFloat = 44
  private static let contextViewHeight: CGFloat = 20
  private static let titleFontSize: CGFloat = UIFont.labelFontSize()
  static let spacing: CGFloat = 8

  // MARK: Views
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
    titleLabel.font = UIFont.systemFontOfSize(LinkView.titleFontSize)
    titleLabel.text = "A sample title for a sample link"
    Theming.sharedInstance.textColor
      .bindTo(titleLabel.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return titleLabel
  }()

  var contentView: UIView = UIView() {
    willSet {
      contentView.removeFromSuperview()
    }
    didSet {
      addSubview(contentView)
      contentView.snp_remakeConstraints { make in
        make.top.equalTo(contextView.snp_bottom).offset(LinkView.spacing)
        make.bottom.equalTo(actionBarView.snp_top).offset(-LinkView.spacing)
        make.left.equalTo(self).offset(LinkView.spacing)
        make.right.equalTo(self).inset(LinkView.spacing)
      }
    }
  }

  // MARK: Subview Accessors
  var shareButton: UIButton {
    return actionBarView.shareButton
  }

  var upvoteButton: UIButton {
    return actionBarView.upvoteButton
  }

  var downvoteButton: UIButton {
    return actionBarView.downvoteButton
  }

  var commentsButton: UIButton {
    return actionBarView.commentsButton
  }

  var votesButton: UIButton {
    return actionBarView.votesButton
  }

  var subredditButton: UIButton {
    return contextView.subredditButton
  }

  var authorButton: UIButton {
    return contextView.authorButton
  }

  var timeAgoLabel: UILabel {
    return contextView.timeAgoLabel
  }

  lazy var contextView: LinkContextView = {
    let contextView = LinkContextView()
    return contextView
  }()

  lazy var actionBarView: LinkActionBarView = {
    let actionBarView = LinkActionBarView()
    return actionBarView
  }()


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
    addSubview(titleLabel)
    addSubview(contextView)
    addSubview(contentView)
    addSubview(actionBarView)
    setupConstraints()
  }

  private func setupConstraints() {
    titleLabel.snp_makeConstraints { make in
      make.top.left.equalTo(self).offset(LinkView.spacing)
      make.right.equalTo(self).inset(LinkView.spacing)
    }

    contextView.snp_updateConstraints { make in
      make.top.equalTo(titleLabel.snp_bottom).offset(LinkView.spacing)
      make.left.equalTo(self).offset(LinkView.spacing)
      make.right.equalTo(self).inset(LinkView.spacing)
      make.height.equalTo(LinkView.contextViewHeight)
    }

    contentView.snp_makeConstraints { make in
      make.top.equalTo(contextView.snp_bottom).offset(LinkView.spacing)
      make.bottom.equalTo(actionBarView.snp_top).offset(-LinkView.spacing)
      make.left.equalTo(self).offset(LinkView.spacing)
      make.right.equalTo(self).inset(LinkView.spacing)
    }
    actionBarView.snp_makeConstraints { make in
      make.left.equalTo(self).offset(LinkView.spacing)
      make.bottom.right.equalTo(self).inset(LinkView.spacing)
      make.height.equalTo(LinkView.actionBarViewHeight)
    }
  }
}
