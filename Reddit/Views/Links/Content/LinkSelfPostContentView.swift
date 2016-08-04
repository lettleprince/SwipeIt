//
//  LinkSelfPostContentView.swift
//  Reddit
//
//  Created by Ivan Bruel on 14/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit
import TTTAttributedLabel

// MARK: Properties and Initializer
class LinkSelfPostContentView: UIView {

  // MARK: Constants
  private static let fontSize = UIFont.smallSystemFontSize()
  private static let readMoreURL = NSURL(string: "reddit://read_more")!

  // MARK: Inner Views
  private lazy var label: TTTAttributedLabel = {
    let label = TTTAttributedLabel(frame: CGRect.zero)
    label.font = UIFont.systemFontOfSize(LinkSelfPostContentView.fontSize)
    label.textAlignment = .Left
    label.delegate = self
    label.truncationLineEnabled = true
    label.enabledTextCheckingTypes = NSTextCheckingType.Link.rawValue

    Theming.sharedInstance.textColor
      .bindTo(label.rx_textColor)
      .addDisposableTo(self.rx_disposeBag)

    Theming.sharedInstance.accentColor
      .subscribeNext { accentColor in
        label.linkAttributes = [NSForegroundColorAttributeName: accentColor]
        label.activeLinkAttributes = [NSForegroundColorAttributeName:
          accentColor.colorWithAlphaComponent(0.5)]
        let attributes = [NSLinkAttributeName: readMoreURL,
          NSForegroundColorAttributeName: accentColor]
        label.attributedTruncationToken =
          NSAttributedString(string: tr(.LinkContentSelfPostReadMore), attributes: attributes)
      }.addDisposableTo(self.rx_disposeBag)

    return label
  }()

  var readMoreClicked: (() -> Void)? = nil

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

    addSubview(label)

    label.snp_makeConstraints { make in
      make.edges.equalTo(self)
    }
  }

  // MARK: API
  var selfText: NSAttributedString? {
    get {
      return label.attributedText
    }
    set {
      label.setText(newValue)
    }
  }

  var numberOfLines: Int {
    get {
      return label.numberOfLines
    }
    set {
      label.numberOfLines = newValue
    }
  }
}

extension LinkSelfPostContentView: TTTAttributedLabelDelegate {

  func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
    guard url != LinkSelfPostContentView.readMoreURL else {
      readMoreClicked?()
      return
    }
    URLRouter.sharedInstance.openURL(url)
  }
}
