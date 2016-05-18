//
//  LinkListImageViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializer
class LinkListImageViewModel: LinkListItemViewModel {

  // MARK: LinkListItemViewModel Private Properties
  let user: User?
  let accessToken: AccessToken?
  let link: Link
  let vote: Variable<Vote>
  let disposeBag = DisposeBag()

  // MARK: Public Properties
  let imageURL: NSURL?

  init(user: User?, accessToken: AccessToken?, link: Link) {
    self.user = user
    self.accessToken = accessToken
    self.link = link

    imageURL = LinkListImageViewModel.imageFromLink(link)
    vote = Variable(link.vote)

    setupObservers()
  }
}

extension LinkListImageViewModel {

  private class func imageFromLink(link: Link) -> NSURL? {
    let firstPreviewImage = link.previewImages?.first
    return firstPreviewImage?.source.url ?? firstPreviewImage?.resolutions.last?.url
      ?? link.thumbnailURL
  }
}
