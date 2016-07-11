//
//  LinkListImageViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

// MARK: Properties and initializer
class LinkListImageViewModel: LinkListItemViewModel {

  private static let defaultImageSize = CGSize(width: 4, height: 3)

  // MARK: Private Properties
  private var prefetcher: Prefetcher? = nil

  // MARK: LinkListItemViewModel Private Properties
  let user: User?
  let accessToken: AccessToken?
  let link: Link
  let vote: Variable<Vote>
  let disposeBag = DisposeBag()

  // MARK: Public Properties
  let imageURL: NSURL?
  let indicator: String?
  let overlay: String?
  let imageSize: Variable<CGSize>


  init(user: User?, accessToken: AccessToken?, link: Link) {
    self.user = user
    self.accessToken = accessToken
    self.link = link

    imageURL = link.imageURL
    vote = Variable(link.vote)
    indicator = LinkListImageViewModel.indicatorFromLink(link)
    overlay = LinkListImageViewModel.overlayFromLink(link)
    imageSize = Variable(link.imageSize ?? LinkListImageViewModel.defaultImageSize)
    setupObservers()
  }

  deinit {
    prefetcher?.stop()
  }

  func preloadData() {
    guard let imageURL = imageURL else { return }
    prefetcher = Prefetcher(imageURL: imageURL) { [weak self] image in
      guard let image = image else { return }
      self?.imageSize.value = image.size
    }
    prefetcher?.start()
  }
}

extension LinkListImageViewModel {

  private class func indicatorFromLink(link: Link) -> String? {
    if link.type == .GIF {
      return tr(.LinkIndicatorGIF)
    } else if link.type == .Album {
      return tr(.LinkIndicatorAlbum)
    } else if link.isSpoiler {
      return tr(.LinkIndicatorSpoiler)
    } else if link.nsfw == true {
      return tr(.LinkIndicatorNSFW)
    }
    return nil
  }

  private class func overlayFromLink(link: Link) -> String? {
    if link.nsfw == true {
      return tr(.LinkIndicatorNSFW)
    } else if link.isSpoiler {
      return tr(.LinkIndicatorSpoiler)
    }
    return nil
  }
}
