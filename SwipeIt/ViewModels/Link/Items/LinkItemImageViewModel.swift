//
//  LinkItemImageViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

// MARK: Properties and initializer
class LinkItemImageViewModel: LinkItemViewModel {

  // MARK: Constants
  private static let defaultImageSize = CGSize(width: 4, height: 3)

  // MARK: Private Properties
  private var prefetcher: Prefetcher? = nil
  private let _imageSize: Variable<CGSize>

  // MARK: Public Properties
  let imageURL: NSURL?
  let indicator: String?
  let overlay: String?
  var imageSize: Observable<CGSize> {
    return _imageSize.asObservable()
  }

  override init(user: User, accessToken: AccessToken, link: Link, showSubreddit: Bool) {
    imageURL = link.imageURL
    indicator = LinkItemImageViewModel.indicatorFromLink(link)
    overlay = LinkItemImageViewModel.overlayFromLink(link)
    _imageSize = Variable(link.imageSize ?? LinkItemImageViewModel.defaultImageSize)

    super.init(user: user, accessToken: accessToken, link: link, showSubreddit: showSubreddit)
  }

  deinit {
    prefetcher?.stop()
  }

  // MARK: API
  func setImageSize(imageSize: CGSize) {
    _imageSize.value = imageSize
  }

  override func preloadData() {
    guard let imageURL = imageURL else { return }
    prefetcher = Prefetcher(imageURL: imageURL) { [weak self] image in
      guard let image = image else { return }
      self?._imageSize.value = image.size
    }
    prefetcher?.start()
  }
}

// MARK: Helpers
extension LinkItemImageViewModel {

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
