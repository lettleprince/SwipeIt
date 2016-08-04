//
//  LinkImageCell.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Kingfisher

class LinkImageCell: LinkCell {

  @IBOutlet weak var linkImageView: LinkImageView! {
    didSet {
      linkView = linkImageView
    }
  }

  var linkImageViewModel: LinkItemImageViewModel! {
    didSet {
      linkViewModel = linkImageViewModel

      linkImageViewModel.imageSize.asObservable()
        .distinctUntilChanged()
        .subscribeNext { [weak self] size in
          self?.linkImageView.setImageSize(size)
        }.addDisposableTo(rx_reusableDisposeBag)

      linkImageView.setImageWithURL(linkImageViewModel.imageURL) { [weak self] (image, imageURL) in

          guard let `self` = self, image = image
            where imageURL == self.linkImageViewModel.imageURL else {
              return
          }
          self.linkImageViewModel.setImageSize(image.size)
      }

      linkImageView.overlayText = linkImageViewModel.overlay
      linkImageView.indicatorText = linkImageViewModel.indicator
    }
  }

  func playGIF() {
    linkImageView.playGIF()
  }

  func stopGIF() {
    linkImageView.stopGIF()
  }
}
