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
import TTTAttributedLabel

@IBDesignable
class LinkCardView: UIView {

  // MARK: - Constants
  private static let titleFontSize = UIFont.systemFontSize()
  private static let fontSize = UIFont.smallSystemFontSize()
  private static let spacing: CGFloat = 10

  // MARK: - ViewModel
  var viewModel: LinkItemViewModel? {
    didSet {
      guard let viewModel = viewModel else { return }
      animateOverlayPercentage(0)
      titleLabel.text = viewModel.title
      viewModel.context
        .subscribeNext { [weak self] context in
          self?.contextLabel.setText(context)
        }.addDisposableTo(rx_disposeBag)
      LinkCardView.statsAttributedString(viewModel.scoreIcon, score: viewModel.score,
        commentsIcon: viewModel.commentsIcon, comments: viewModel.comments)
        .bindTo(statsLabel.rx_attributedText)
        .addDisposableTo(rx_disposeBag)
    }
  }

  // MARK: - Views
  private lazy var containerView: UIView = {
    let view = UIView()
    view.addSubview(self.titleLabel)
    view.addSubview(self.contextLabel)
    view.addSubview(self.statsLabel)
    view.addSubview(self.upvoteOverlayImageView)
    view.addSubview(self.downvoteOverlayImageView)
    return view
  }()

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Vertical)
    label.font = UIFont.boldSystemFontOfSize(LinkCardView.titleFontSize)
    Theming.sharedInstance.textColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return label
  }()

  private lazy var contextLabel: TTTAttributedLabel = {
    let label = TTTAttributedLabel(frame: CGRect.zero)
    label.font = UIFont.systemFontOfSize(LinkCardView.fontSize)
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
  }()

  private lazy var statsLabel: UILabel = {
    let label = UILabel(frame: CGRect.zero)
    label.font = UIFont.systemFontOfSize(LinkCardView.fontSize)
    label.textAlignment = .Right

    Theming.sharedInstance.textColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)

    return label
  }()

  private lazy var upvoteOverlayImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(asset: .UpvoteOverlay))
    imageView.contentMode = .ScaleAspectFit
    imageView.alpha = 0
    imageView.tintColor = UIColor(named: .Orange)
    return imageView
  }()

  private lazy var downvoteOverlayImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(asset: .DownvoteOverlay))
    imageView.contentMode = .ScaleAspectFit
    imageView.alpha = 0
    imageView.tintColor = UIColor(named: .Purple)
    return imageView
  }()

  var contentView: UIView? = nil {
    didSet {
      guard let contentView = contentView else { return }
      containerView.addSubview(contentView)
      contentView.snp_makeConstraints { make in
        make.top.equalTo(contextLabel.snp_bottom).offset(LinkCardView.spacing)
        make.bottom.equalTo(statsLabel.snp_top)
        make.left.right.equalTo(containerView)
      }
      containerView.bringSubviewToFront(upvoteOverlayImageView)
      containerView.bringSubviewToFront(downvoteOverlayImageView)
    }
    willSet {
      contentView?.removeFromSuperview()
    }
  }

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
    borderColor = UIColor(named: .DarkGray)
    borderWidth = 1
    cornerRadius = 4

    addSubview(containerView)
    setupConstraints()
  }

  private func setupConstraints() {
    containerView.snp_makeConstraints { make in
      make.top.left.equalTo(self)
      make.width.equalTo(bounds.width)
      make.height.equalTo(bounds.height)
    }

    titleLabel.snp_makeConstraints { make in
      make.top.left.equalTo(containerView).offset(LinkCardView.spacing)
      make.right.equalTo(containerView).inset(LinkCardView.spacing)
    }

    contextLabel.snp_makeConstraints { make in
      make.top.equalTo(titleLabel.snp_bottom).offset(LinkCardView.spacing)
      make.left.equalTo(containerView).offset(LinkCardView.spacing)
      make.right.equalTo(containerView).inset(LinkCardView.spacing)
    }

    statsLabel.snp_makeConstraints { make in
      make.bottom.equalTo(containerView)
      make.right.equalTo(containerView).inset(LinkCardView.spacing)
      make.left.equalTo(containerView).offset(LinkCardView.spacing)
      make.height.equalTo(44)
    }

    upvoteOverlayImageView.snp_makeConstraints { make in
      make.top.equalTo(contextLabel.snp_bottom)
        .offset(LinkCardView.spacing * 2)
      make.left.equalTo(containerView).offset(LinkCardView.spacing)
    }

    downvoteOverlayImageView.snp_makeConstraints { make in
      make.top.equalTo(contextLabel.snp_bottom)
        .offset(LinkCardView.spacing * 2)
      make.right.equalTo(containerView).offset(-LinkCardView.spacing)
    }

    [titleLabel, contextLabel, statsLabel]
      .forEach { $0.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical) }

    statsLabel.setContentCompressionResistancePriority(UILayoutPriorityDefaultHigh,
                                                       forAxis: .Horizontal)
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

  var statsText: String? {
    get {
      return statsLabel.text
    }
    set {
      statsLabel.text = newValue
    }
  }

  // MARK: Lifecycle
  func didAppear() { }

  func didDisappear() {
    animateOverlayPercentage(0)
  }

  // MARK: Animation
  func animateOverlayPercentage(percentage: CGFloat) {
    upvoteOverlayImageView.alpha = max(min(percentage, 1), 0)
    downvoteOverlayImageView.alpha = max(min(-percentage, 1), 0)
  }
}

extension LinkCardView {

  private static func statsAttributedString(scoreIcon: Observable<UIImage>,
                                            score: Observable<NSAttributedString>,
                                            commentsIcon: Observable<UIImage>,
                                            comments: Observable<NSAttributedString>)
    -> Observable<NSAttributedString?> {
      let commentsIcon = commentsIcon
        .map { commentsIcon -> NSAttributedString  in
          let attachment = ImageAttachment(commentsIcon,
            verticalOffset: UIFont.systemFontOfSize(LinkCardView.fontSize).descender)
          return NSAttributedString(attachment: attachment)
      }
      let scoreIcon = scoreIcon
        .map { scoreIcon -> NSAttributedString in
          let attachment = ImageAttachment(scoreIcon,
            verticalOffset: UIFont.systemFontOfSize(LinkCardView.fontSize).descender)
          return NSAttributedString(attachment: attachment)
      }
      return Observable
        .combineLatest(scoreIcon, score, commentsIcon, comments) {
          ($0, $1, $2, $3)
        }.map { (scoreIcon, score, commentsIcon, comments) in
          return [scoreIcon, score, commentsIcon, comments].joinWithSeparator(" ")
      }
  }
}

extension LinkCardView: TTTAttributedLabelDelegate {
  
}
