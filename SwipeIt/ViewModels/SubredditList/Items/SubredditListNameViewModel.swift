//
//  SubredditViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// MARK: Properties and Initializer
class SubredditListNameViewModel: SubredditListItemViewModel {

  // MARK: Private Properties
  private let user: User
  private let accessToken: AccessToken
  private let path: String

  // MARK: Public Properties
  let name: String

  var linkSwipeViewModel: LinkSwipeViewModel {
    return LinkSwipeViewModel(user: user, accessToken: accessToken, title: name, path: path,
                             subredditOnly: false)
  }

  // MARK: Initializer
  init(user: User, accessToken: AccessToken, name: String, path: String) {
    self.user = user
    self.accessToken = accessToken
    self.name = name
    self.path = path
  }
}
