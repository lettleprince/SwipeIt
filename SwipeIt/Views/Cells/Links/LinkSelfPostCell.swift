//
//  LinkSelfPostCell.swift
//  Reddit
//
//  Created by Ivan Bruel on 14/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift

class LinkSelfPostCell: LinkCell {

  private let readMore = PublishSubject<LinkItemSelfPostViewModel>()

  @IBOutlet weak var linkSelfPostView: LinkSelfPostView! {
    didSet {
      linkView = linkSelfPostView
    }
  }

  var linkSelfPostViewModel: LinkItemSelfPostViewModel! {
    didSet {
      linkViewModel = linkSelfPostViewModel

      linkSelfPostView.selfText = linkSelfPostViewModel.selfText
    }
  }

  var numberOfLines: Int = Globals.selfPostNumberOfLines {
    didSet {
      linkSelfPostView.numberOfLines = numberOfLines
    }
  }

  // swiftlint:disable variable_name
  var rx_readMore: Observable<LinkItemSelfPostViewModel> {
    return readMore.asObservable()
  }
  // swiftlint:enable variable_name

  private func readMoreClicked() {
    readMore.onNext(linkSelfPostViewModel)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    linkSelfPostView.numberOfLines = numberOfLines
    linkSelfPostView.readMoreClicked = readMoreClicked
  }

  deinit {
    readMore.dispose()
  }
}
