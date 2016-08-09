//
//  LinkView.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift
import TTTAttributedLabel

// MARK: Properties and Initializers
@IBDesignable class LinkView: UIView {

  // MARK: Constants
  private static let actionBarViewHeight: CGFloat = 44
  private static let titleFontSize: CGFloat = UIFont.labelFontSize()
  private static let contextFontSize: CGFloat = UIFont.smallSystemFontSize()
  static let spacing: CGFloat = 8
  static let tagAttributeName = "LinkViewTagAttributeName"

  // MARK: Views
  lazy var titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
    titleLabel.font = UIFont.systemFontOfSize(LinkView.titleFontSize)
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
        make.top.equalTo(contextLabel.snp_bottom).offset(LinkView.spacing*1.25)
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

  lazy var contextLabel: TTTAttributedLabel = {
    let label = TTTAttributedLabel(frame: CGRect.zero)
    label.font = UIFont.systemFontOfSize(LinkView.contextFontSize)
    label.numberOfLines = 0
    label.textAlignment = .Left
    label.delegate = self

    Theming.sharedInstance.secondaryTextColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)

    Theming.sharedInstance.accentColor
      .subscribeNext { accentColor in
        label.linkAttributes = [NSForegroundColorAttributeName: accentColor]
        label.activeLinkAttributes = [NSForegroundColorAttributeName:
          accentColor.colorWithAlphaComponent(0.5)]
      }.addDisposableTo(self.rx_disposeBag)

    return label
  }()

  lazy var actionBarView: LinkActionBarView = {
    let actionBarView = LinkActionBarView()
    return actionBarView
  }()

  private var disposeBag = DisposeBag()


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
    addSubview(contextLabel)
    addSubview(contentView)
    addSubview(actionBarView)
    setupConstraints()
  }

  /**
   Transforms tagAttributeNames into proper coloring, corner radius and paddings. Also adds the
   default text color, sets a line spacing value and sets the text on the label.

   - parameter contextAttributedText: The attributed text with tagAttributeNames.
   */
  func setContextAttributedText(contextAttributedText: NSAttributedString) {
    disposeBag = DisposeBag()
    Observable.combineLatest(Theming.sharedInstance.theme,
      Observable.just(contextAttributedText)) { ($0, $1) }
      .subscribeNext { (theme, contextAttributedText) in
        let attributedText = NSMutableAttributedString(attributedString: contextAttributedText)
        attributedText.setLineSpacing(LinkView.spacing/2)
        attributedText.setTextColor(theme.secondaryTextColor)
        let insets = UIEdgeInsets(top: LinkView.spacing/2, left: 0, bottom: LinkView.spacing/2,
          right: 0)
        let tagAttributes = [kTTTBackgroundFillColorAttributeName: theme.accentColor,
          NSForegroundColorAttributeName: UIColor.whiteColor(),
          kTTTBackgroundCornerRadiusAttributeName: LinkView.spacing/2,
          kTTTBackgroundFillPaddingAttributeName: NSValue(UIEdgeInsets: insets)]
        attributedText.replaceAttribute(LinkView.tagAttributeName, attributes: tagAttributes)
               self.contextLabel.setText(attributedText)
    }.addDisposableTo(disposeBag)
  }

  private func setupConstraints() {
    titleLabel.snp_makeConstraints { make in
      make.top.left.equalTo(self).offset(LinkView.spacing)
      make.right.equalTo(self).inset(LinkView.spacing)
    }

    contextLabel.snp_updateConstraints { make in
      make.top.equalTo(titleLabel.snp_bottom).offset(LinkView.spacing*1.25)
      make.left.equalTo(self).offset(LinkView.spacing)
      make.right.equalTo(self).inset(LinkView.spacing)
    }

    contentView.snp_makeConstraints { make in
      make.top.equalTo(contextLabel.snp_bottom).offset(LinkView.spacing*1.25)
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

  override func prepareForInterfaceBuilder() {
    titleLabel.text = "A sample title for a sample link"
  }
}

extension LinkView: TTTAttributedLabelDelegate {

  func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
    print(url)
  }
}
