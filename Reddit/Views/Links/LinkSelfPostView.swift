//
//  LinkSelfPostView.swift
//  Reddit
//
//  Created by Ivan Bruel on 14/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: Properties and Initializer
class LinkSelfPostView: LinkView {

  // MARK: Private Properties
  private let selfPostContentView = LinkSelfPostContentView()

  // MARK: Initializer
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    contentView = selfPostContentView
  }

  // MARK: API
  var selfText: NSAttributedString? {
    get {
      return selfPostContentView.selfText
    }
    set {
      selfPostContentView.selfText = newValue
    }
  }

  var numberOfLines: Int {
    get {
      return selfPostContentView.numberOfLines
    }
    set {
      selfPostContentView.numberOfLines = newValue
    }
  }

  var readMoreClicked: (() -> Void)? {
    get {
      return selfPostContentView.readMoreClicked
    }
    set {
      selfPostContentView.readMoreClicked = newValue
    }
  }
}
