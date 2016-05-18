//
//  SubredditListSubredditViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// MARK: Properties and Initializer
class SubredditListSubredditViewModel: SubredditListItemViewModel {

  // MARK: Private Properties
  private let user: User?
  private let accessToken: AccessToken?
  private let subreddit: Subreddit

  // MARK: Public Properties
  var name: String {
    return subreddit.displayName
  }

  var linkListViewModel: LinkListViewModel {
    return LinkListViewModel(user: user, accessToken: accessToken, subreddit: subreddit)
  }

  // MARK: Initializer
  init(user: User?, accessToken: AccessToken?, subreddit: Subreddit) {
    self.user = user
    self.accessToken = accessToken
    self.subreddit = subreddit
  }
}
