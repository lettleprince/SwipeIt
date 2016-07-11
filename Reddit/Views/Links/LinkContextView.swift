//
//  LinkContextView.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

enum LinkContext {
  case TimeAgo
  case Subreddit
  case Author
  case Gold
  case Locked
  case Stickied
}

@IBDesignable class LinkContextView: UIView {

  // MARK: Inspectable Properties
  @IBInspectable var fontSize: CGFloat = UIFont.smallSystemFontSize() {
    didSet {
      labels.forEach { $0.font = UIFont.systemFontOfSize(fontSize) }
      buttons.forEach { $0.titleLabel?.font = UIFont.systemFontOfSize(fontSize/2) }
    }
  }

  @IBInspectable var separator: String = "●" {
    didSet {
      separatorLabels.forEach { $0.text = separator }
    }
  }

  @IBInspectable var spacing: CGFloat = 4 {
    didSet {
      stackView.spacing = spacing
    }
  }

  // MARK: Views
  lazy var timeAgoLabel: UILabel = self.buildLabel()
  lazy var authorButton: UIButton = self.buildButton()
  lazy var subredditButton: UIButton = self.buildButton()
  lazy var goldLabel: UILabel = self.buildLabel()
  lazy var lockedLabel: UILabel = {
    let lockedLabel = self.buildLabel()
    lockedLabel.text = tr(.LinkContextLocked)
    return lockedLabel
  }()

  lazy var stickiedLabel: UILabel = {
    let lockedLabel = self.buildLabel()
    lockedLabel.text = tr(.LinkContextStickied)
    return lockedLabel
  }()

  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [])
    stackView.spacing = self.spacing
    stackView.distribution = .Fill
    return stackView
  }()

  private var separatorLabels: [UILabel] = []
  private var labels: [UILabel] {
    return stackView.arrangedSubviews.flatMap { $0 as? UILabel }
  }
  private var buttons: [UIButton] {
    return stackView.arrangedSubviews.flatMap { $0 as? UIButton }
  }

  var linkContext: [LinkContext] = [] {
    didSet {
      build()
    }
  }

  // MARK: Init
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

  // MARK: View Builders
  private func buildSeparatorLabel() -> UILabel {
    let separatorLabel = UILabel()
    separatorLabel.font = UIFont.systemFontOfSize(self.fontSize/2)
    separatorLabel.text = self.separator
    Theming.sharedInstance.secondaryTextColor
      .bindTo(separatorLabel.rx_textColor)
      .addDisposableTo(separatorLabel.rx_disposeBag)
    return separatorLabel
  }

  private func buildButton() -> UIButton {
    let button = LabelButton(type: .System)
    button.titleLabel?.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.accentColor
      .bindTo(button.rx_titleColor)
      .addDisposableTo(button.rx_disposeBag)
    return button
  }

  private func buildLabel() -> UILabel {
    let label = UILabel()
    label.font = UIFont.systemFontOfSize(self.fontSize)
    Theming.sharedInstance.secondaryTextColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(label.rx_disposeBag)
    return label
  }

  private func build() {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    linkContext.forEach { self.addLinkContext($0) }

    if let lastSeparator = separatorLabels.last {
      lastSeparator.removeFromSuperview()
      separatorLabels.removeLast()
    }
  }

  private func addLinkContext(linkContext: LinkContext) {
    switch linkContext {
    case .TimeAgo:
      stackView.addArrangedSubview(timeAgoLabel)
    case .Subreddit:
      stackView.addArrangedSubview(subredditButton)
    case .Author:
      stackView.addArrangedSubview(authorButton)
    case .Gold:
      stackView.addArrangedSubview(goldLabel)
    case .Locked:
      stackView.addArrangedSubview(lockedLabel)
    case .Stickied:
      stackView.addArrangedSubview(stickiedLabel)
    }

    let separatorLabel = buildSeparatorLabel()
    stackView.addArrangedSubview(separatorLabel)
    separatorLabels.append(separatorLabel)
  }

}
