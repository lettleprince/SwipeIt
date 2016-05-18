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
  @IBInspectable var fontSize: CGFloat = 11 {
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

  private lazy var timeAgoLabel: UILabel = {
    let timeAgoLabel = UILabel()
    timeAgoLabel.font = UIFont.systemFontOfSize(self.fontSize)
    timeAgoLabel.textColor = UIColor.darkGrayColor()
    timeAgoLabel.text = "9h"
    return timeAgoLabel
  }()

  private lazy var firstSeparatorLabel: UILabel = {
    let firstSeparatorLabel = UILabel()
    firstSeparatorLabel.font = UIFont.systemFontOfSize(self.fontSize)
    firstSeparatorLabel.textColor = UIColor.darkGrayColor()
    firstSeparatorLabel.text = self.separator
    return firstSeparatorLabel
  }()

  private lazy var authorButton: UIButton = {
    let authorButton = UIButton(type: UIButtonType.System)
    authorButton.setTitle("Author", forState: .Normal)
    authorButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    return authorButton
  }()

  private lazy var secondSeparatorLabel: UILabel = {
    let secondSeparatorLabel = UILabel()
    secondSeparatorLabel.font = UIFont.systemFontOfSize(self.fontSize)
    secondSeparatorLabel.textColor = UIColor.darkGrayColor()
    secondSeparatorLabel.text = self.separator
    return secondSeparatorLabel
  }()

  private lazy var subredditButton: UIButton = {
    let subredditButton = UIButton(type: UIButtonType.System)
    subredditButton.setTitle("Subreddit", forState: .Normal)
    subredditButton.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    return subredditButton
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [self.timeAgoLabel, self.firstSeparatorLabel,
      self.authorButton, self.secondSeparatorLabel, self.subredditButton])
    stackView.spacing = self.spacing
    stackView.distribution = .EqualSpacing
    stackView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
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
    stackView.backgroundColor = .redColor()
    stackView.bounds = bounds
  }

  override func intrinsicContentSize() -> CGSize {
    let height = bounds.height
    let width = CGFloat(max(stackView.arrangedSubviews.count - 1, 0)) * spacing
      + stackView.arrangedSubviews.reduce(0) { (width, view) -> CGFloat in
      return width + view.intrinsicContentSize().width
    }
    return CGSize(width: width, height: height)
  }
}
