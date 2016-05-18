//
//  LinkListSelfPostViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializer
class LinkListSelfPostViewModel: LinkListItemViewModel {

  // MARK: LinkListItemViewModel Private Properties
  let user: User?
  let accessToken: AccessToken?
  let link: Link
  let vote: Variable<Vote>
  let disposeBag = DisposeBag()

  // MARK: Public Properties
  let selfText: String

  init(user: User?, accessToken: AccessToken?, link: Link) {
    self.user = user
    self.accessToken = accessToken
    self.link = link

    selfText = link.selfText ?? ""
    vote = Variable(link.vote)

    setupObservers()
  }
}
