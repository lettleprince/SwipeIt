//
//  LinkCell.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Cell_Rx

class LinkCell: UITableViewCell, ReusableCell {

  @IBOutlet weak var linkView: LinkView!

  override class func requiresConstraintBasedLayout() -> Bool {
    return true
  }

  var linkViewModel: LinkListItemViewModel! {
    didSet {
      linkView.titleLabel.text = linkViewModel.title
      linkViewModel.timeAgo
        .bindTo(linkView.timeAgoLabel.rx_text)
        .addDisposableTo(rx_reusableDisposeBag)
      linkView.contextView.linkContext = linkViewModel.linkContext
      linkView.authorButton.setTitle(linkViewModel.author, forState: .Normal)
      linkView.subredditButton.setTitle(linkViewModel.subredditName, forState: .Normal)
      linkView.contextView.goldLabel.text = linkViewModel.gilded
      linkViewModel.score
        .subscribeNext { [weak self] score in
          self?.linkView.votesButton.setTitle(score, forState: .Normal)
      }.addDisposableTo(rx_reusableDisposeBag)

      linkView.commentsButton.setTitle(linkViewModel.totalComments, forState: .Normal)
    }
  }
}
