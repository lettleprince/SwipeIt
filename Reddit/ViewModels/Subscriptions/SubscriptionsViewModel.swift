//
//  SubscriptionsViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 03/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and Initializer
class SubscriptionsViewModel {

  // MARK: Public Properties
  var subredditListViewModel: SubredditListViewModel {
    return SubredditListViewModel(user: user, accessToken: accessToken)
  }

  var multiredditListViewModel: MultiredditListViewModel {
    return MultiredditListViewModel(user: user, accessToken: accessToken)
  }

  var title: Observable<String> {
    return .just(tr(.SubscriptionsTitle))
  }

  // MARK: Private Properties
  private let user: User?
  private let accessToken: AccessToken?

  // MARK: Initializer
  init(user: User?, accessToken: AccessToken?) {
    self.user = user
    self.accessToken = accessToken
  }

}
