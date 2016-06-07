//
//  LinkListVideoViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializer
class LinkListVideoViewModel: LinkListItemViewModel {

  // MARK: LinkListItemViewModel Private Properties
  let user: User?
  let accessToken: AccessToken?
  let link: Link
  let vote: Variable<Vote>
  let disposeBag = DisposeBag()

  // MARK: Public Properties
  let imageURL: NSURL?
  let videoURL: NSURL
  let openGraphViewModel: OpenGraphViewModel

  init(user: User?, accessToken: AccessToken?, link: Link) {
    self.user = user
    self.accessToken = accessToken
    self.link = link

    imageURL = link.imageURL
    videoURL = link.url
    openGraphViewModel = OpenGraphViewModel(url: link.url)
    vote = Variable(link.vote)

    setupObservers()
  }
}
