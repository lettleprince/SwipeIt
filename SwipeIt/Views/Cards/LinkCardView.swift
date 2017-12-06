//
//  LinkCardView.swift
//  Reddit
//
//  Created by Ivan Bruel on 19/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxColor
import RxSwift
import TextStyle
import TTTAttributedLabel

class LinkCardView: UIView {

  // MARK: - Constants
  private static let spacing: CGFloat = 10

  // MARK: - ViewModel
  var viewModel: LinkItemViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      animateOverlayPercentage(0)
      titleLabel.text = viewModel.title

      Observable
        .combineLatest(viewModel.context, TextStyle.Caption1.rx_font,
        Theming.sharedInstance.secondaryTextColor) { ($0, $1, $2) }
        .subscribeNext { [weak self] (context, font, textColor) in
          guard let context = context else {
            self?.contextLabel.setText(nil)
            return
          }
          let mutableContext = NSMutableAttributedString(attributedString: context)
          mutableContext.setFont(font)
          mutableContext.setTextColor(textColor)
          self?.contextLabel.setText(mutableContext)
        }.addDisposableTo(rx_disposeBag)

      LinkCardView
        .statsAttributedString(viewModel.scoreIcon, text: viewModel.score,
          font: TextStyle.Caption1.rx_font)
        .bindTo(scoreLabel.rx_attributedText)
        .addDisposableTo(rx_disposeBag)

      LinkCardView
        .statsAttributedString(viewModel.commentsIcon, text: viewModel.comments,
          font: TextStyle.Caption1.rx_font)
        .bindTo(commentsLabel.rx_attributedText)
        .addDisposableTo(rx_disposeBag)
    }
  }

  // MARK: - Views
  private lazy var containerView: UIView = self.createContentView()
  private lazy var titleLabel: UILabel = self.createTitleLabel()
  private lazy var contextLabel: TTTAttributedLabel = self.createContextLabel()
  private lazy var topBar: UIVisualEffectView = self.createTopBar()
  private lazy var bottomBar: UIVisualEffectView = self.createBottomBar()
  private lazy var commentsLabel: UILabel = self.createStatsLabel()
  private lazy var scoreLabel: UILabel = self.createScoreLabel()
  private lazy var upvoteOverlayImageView: VoteOverlayView = self.createUpvoteOverlayView()
  private lazy var downvoteOverlayImageView: VoteOverlayView = self.createDownvoteOverlayView()
  lazy var moreButton: UIButton = self.createMoreButton()

  var contentView: UIView? = nil {
    didSet {
      guard let contentView = contentView else { return }
      containerView.addSubview(contentView)
      contentView.snp_makeConstraints { make in
        make.top.equalTo(contextLabel.snp_bottom).offset(LinkCardView.spacing)
        make.bottom.equalTo(bottomBar.snp_top)
        make.left.right.equalTo(containerView)
      }
      containerView.bringSubviewToFront(upvoteOverlayImageView)
      containerView.bringSubviewToFront(downvoteOverlayImageView)
      containerView.bringSubviewToFront(bottomBar)
    }
    willSet {
      contentView?.removeFromSuperview()
    }
  }

  var moreOptionsClicked: ((LinkCardView) -> Void)? = nil

  // MARK: - Initializers
  init() {
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
    backgroundColor = .whiteColor()
    borderColor = UIColor(named: .Gray)
    borderWidth = 1
    cornerRadius = 4
    clipsToBounds = true
    opaque = true

    addSubview(containerView)
    setupConstraints()
  }

  private func setupConstraints() {
    containerView.snp_makeConstraints { make in
      make.top.left.equalTo(self)
      make.width.equalTo(bounds.width)
      make.height.equalTo(bounds.height)
    }

    topBar.snp_makeConstraints { make in
      make.top.left.right.equalTo(containerView)
    }

    titleLabel.snp_makeConstraints { make in
      make.top.left.equalTo(topBar).offset(LinkCardView.spacing)
      make.right.equalTo(topBar).inset(LinkCardView.spacing)
    }

    contextLabel.snp_makeConstraints { make in
      make.top.equalTo(titleLabel.snp_bottom).offset(LinkCardView.spacing)
      make.left.equalTo(bottomBar).offset(LinkCardView.spacing)
      make.right.equalTo(bottomBar).inset(LinkCardView.spacing)
      make.bottom.equalTo(topBar).inset(LinkCardView.spacing)
    }

    bottomBar.snp_makeConstraints { make in
      make.bottom.left.right.equalTo(containerView)
      make.height.equalTo(44)
    }

    moreButton.snp_makeConstraints { make in
      make.bottom.equalTo(bottomBar).offset(-LinkCardView.spacing)
      make.right.equalTo(bottomBar).inset(LinkCardView.spacing)
      make.top.equalTo(bottomBar).offset(LinkCardView.spacing)
      make.width.equalTo(moreButton.snp_height)
    }

    commentsLabel.snp_makeConstraints { make in
      make.bottom.equalTo(bottomBar).offset(-LinkCardView.spacing)
      make.top.left.equalTo(bottomBar).offset(LinkCardView.spacing)
    }

    scoreLabel.snp_makeConstraints { make in
      make.bottom.equalTo(bottomBar).offset(-LinkCardView.spacing)
      make.right.equalTo(moreButton.snp_left).offset(-LinkCardView.spacing)
      make.top.equalTo(bottomBar).offset(LinkCardView.spacing)
      make.left.equalTo(commentsLabel.snp_right).offset(LinkCardView.spacing)
    }

    upvoteOverlayImageView.snp_makeConstraints { make in
      make.top.equalTo(topBar.snp_bottom).offset(LinkCardView.spacing * 3)
      make.left.equalTo(containerView).offset(LinkCardView.spacing)
    }

    downvoteOverlayImageView.snp_makeConstraints { make in
      make.top.equalTo(topBar.snp_bottom).offset(LinkCardView.spacing * 3)
      make.right.equalTo(containerView).offset(-LinkCardView.spacing)
    }

    [titleLabel, contextLabel, commentsLabel, scoreLabel]
      .forEach { $0.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical) }

    [commentsLabel, scoreLabel].forEach {
      $0.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
    }
  }
}

// MARK: - API
extension LinkCardView {

  var title: String? {
    get {
      return titleLabel.text
    }
    set {
      titleLabel.text = newValue
    }
  }

  var contextText: String? {
    get {
      return contextLabel.text
    }
    set {
      contextLabel.text = newValue
    }
  }

  var commentsText: String? {
    get {
      return commentsLabel.text
    }
    set {
      commentsLabel.text = newValue
    }
  }

  var scoreText: String? {
    get {
      return scoreLabel.text
    }
    set {
      scoreLabel.text = newValue
    }
  }

  // MARK: Lifecycle
  func didAppear() {
    animateOverlayPercentage(0)
  }

  func didDisappear() {
    animateOverlayPercentage(0)
  }

  // MARK: Animation
  func animateOverlayPercentage(percentage: CGFloat) {
    let upvoteAlpha = max(min(percentage, 1), 0)
    let downvoteAlpha = max(min(-percentage, 1), 0)

    if upvoteAlpha != upvoteOverlayImageView.alpha {
      upvoteOverlayImageView.alpha = upvoteAlpha
    }

    if downvoteAlpha != downvoteOverlayImageView.alpha {
      downvoteOverlayImageView.alpha = downvoteAlpha
    }
  }
}

// MARK: - View Builders
extension LinkCardView {

  private func createContextLabel() -> TTTAttributedLabel {
    let label = TTTAttributedLabel(frame: CGRect.zero)
    label.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
    label.numberOfLines = 1
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
  }

  private func createUpvoteOverlayView() -> VoteOverlayView {
    let view = VoteOverlayView()
    view.text = tr(.LinkUpvote).uppercaseString
    view.tintColor = UIColor(named: .Orange)
    view.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI)/6)
    return view
  }

  private func createDownvoteOverlayView() -> VoteOverlayView {
    let view = VoteOverlayView()
    view.text = tr(.LinkDownvote).uppercaseString
    view.tintColor = UIColor(named: .Purple)
    view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/6)
    return view
  }

  private func createTitleLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)

    TextStyle.Subheadline.rx_font
      .bindTo(label.rx_font)
      .addDisposableTo(self.rx_disposeBag)

    Theming.sharedInstance.textColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return label
  }

  private func createStatsLabel() -> UILabel {
    let label = UILabel(frame: CGRect.zero)
    TextStyle.Caption1.rx_font
      .bindTo(label.rx_font)
      .addDisposableTo(self.rx_disposeBag)
    label.textAlignment = .Right

    Theming.sharedInstance.secondaryTextColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)

    return label
  }

  private func createScoreLabel() -> UILabel {
    let label = createStatsLabel()
    label.textAlignment = .Right
    return label
  }

  private func createMoreButton() -> UIButton {
    let button = UIButton(type: .Custom)
    button.setImage(UIImage(asset: .MoreIcon), forState: .Normal)
    Theming.sharedInstance.accentColor
      .subscribeNext { color in
        button.setImage(UIImage(asset: .MoreIcon).tint(color), forState: .Highlighted)
      }.addDisposableTo(self.rx_disposeBag)
    button.rx_tap.subscribeNext { [weak self] _ in
      guard let `self` = self else { return }
      self.moreOptionsClicked?(self)
    }.addDisposableTo(self.rx_disposeBag)
    return button
  }

  private func createBottomBar() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
    view.addSubview(self.commentsLabel)
    view.addSubview(self.scoreLabel)
    view.addSubview(self.moreButton)
    return view
  }

  private func createTopBar() -> UIVisualEffectView {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
    view.addSubview(self.titleLabel)
    view.addSubview(self.contextLabel)
    return view
  }

  private func createContentView() -> UIView {
    let view = UIView()
    view.addSubview(self.bottomBar)
    view.addSubview(self.topBar)
    view.addSubview(self.upvoteOverlayImageView)
    view.addSubview(self.downvoteOverlayImageView)
    return view
  }
}

// MARK: - Helpers
extension LinkCardView {

  private static func statsAttributedString(icon: Observable<UIImage>,
                                            text: Observable<NSAttributedString>,
                                            font: Observable<UIFont>)
    -> Observable<NSAttributedString?> {

      let icon = iconAttributedString(icon, font: font)

      return Observable.combineLatest(icon, text) {
          [$0, $1].joinWithSeparator(" ")
      }
  }

  private static func iconAttributedString(icon: Observable<UIImage>, font: Observable<UIFont>)
    -> Observable<NSAttributedString> {
      return Observable.combineLatest(icon, font) { (icon, font) -> NSAttributedString in
        let attachment = ImageAttachment(icon, verticalOffset: font.descender)
        return NSAttributedString(attachment: attachment)
      }
  }
}

extension LinkCardView: TTTAttributedLabelDelegate {

}
