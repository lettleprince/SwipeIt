//
//  LinkContextView.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

@IBDesignable class LinkContextView: UIView {

  // MARK: Inspectable Properties
  @IBInspectable var fontSize: CGFloat = UIFont.smallSystemFontSize() {
    didSet {
      timeAgoLabel.font = UIFont.systemFontOfSize(fontSize)
      firstSeparatorLabel.font = UIFont.systemFontOfSize(fontSize)
      authorButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
      secondSeparatorLabel.font = UIFont.systemFontOfSize(fontSize)
      subredditButton.titleLabel?.font = UIFont.systemFontOfSize(fontSize)
    }
  }

  @IBInspectable var separator: String = "●" {
    didSet {
      firstSeparatorLabel.text = separator
      secondSeparatorLabel.text = separator
    }
  }

  @IBInspectable var spacing: CGFloat = 4 {
    didSet {
      stackView.spacing = spacing
    }
  }

  // MARK: Views
  lazy var timeAgoLabel: UILabel = {
    let timeAgoLabel = UILabel()
    timeAgoLabel.font = UIFont.systemFontOfSize(self.fontSize)
    timeAgoLabel.text = "9h"
    Theming.sharedInstance.secondaryTextColor
      .bindTo(timeAgoLabel.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return timeAgoLabel
  }()

  private lazy var firstSeparatorLabel: UILabel = {
    let firstSeparatorLabel = UILabel()
    firstSeparatorLabel.font = UIFont.systemFontOfSize(self.fontSize)
    firstSeparatorLabel.text = self.separator
    Theming.sharedInstance.secondaryTextColor
      .bindTo(firstSeparatorLabel.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return firstSeparatorLabel
  }()

  lazy var authorButton: UIButton = {
    let authorButton = UIButton(type: UIButtonType.System)
    authorButton.setTitle("Author", forState: .Normal)
    authorButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.accentColor
      .bindTo(authorButton.rx_titleColor)
      .addDisposableTo(self.rx_disposeBag)
    return authorButton
  }()

  private lazy var secondSeparatorLabel: UILabel = {
    let secondSeparatorLabel = UILabel()
    secondSeparatorLabel.font = UIFont.systemFontOfSize(self.fontSize)
    secondSeparatorLabel.text = self.separator
    Theming.sharedInstance.secondaryTextColor
      .bindTo(secondSeparatorLabel.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)
    return secondSeparatorLabel
  }()

  lazy var subredditButton: UIButton = {
    let subredditButton = UIButton(type: UIButtonType.System)
    subredditButton.setTitle("Subreddit", forState: .Normal)
    subredditButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.accentColor
      .bindTo(subredditButton.rx_titleColor)
      .addDisposableTo(self.rx_disposeBag)
    return subredditButton
  }()

  private lazy var stackView: UIStackView = {
    let views = [self.timeAgoLabel, self.firstSeparatorLabel,
                 self.authorButton, self.secondSeparatorLabel, self.subredditButton]
    let stackView = UIStackView(arrangedSubviews: views)
    stackView.spacing = self.spacing
    stackView.distribution = .Fill
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
    addSubview(stackView)
    stackView.bounds = bounds
    stackView.snp_makeConstraints { make in
      make.top.bottom.left.equalTo(self)
    }
  }


  private func showSubredditButton() {
    if subredditButton.hidden {
      subredditButton.hidden = false
      secondSeparatorLabel.hidden = false
      stackView.addArrangedSubview(secondSeparatorLabel)
      stackView.addArrangedSubview(subredditButton)
    }
  }

  private func hideSubredditButton() {
    if !subredditButton.hidden {
      subredditButton.hidden = true
      secondSeparatorLabel.hidden = true
      stackView.removeArrangedSubview(subredditButton)
      stackView.removeArrangedSubview(secondSeparatorLabel)
    }
  }
}

// MARK: Public API
extension LinkContextView {

  func setTimeAgo(timeAgo: String) {
    timeAgoLabel.text = timeAgo
  }

  func setSubredditName(subredditName: String?) {
    guard let subredditName = subredditName else {
      hideSubredditButton()
      return
    }
    showSubredditButton()
    subredditButton.setTitle(subredditName, forState: .Normal)
  }

  func setAuthorName(authorName: String) {
    authorButton.setTitle(authorName, forState: .Normal)
  }
}
