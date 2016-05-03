//
//  SubredditListSubredditViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and Initializer
class SubredditListSubredditViewModel: SubredditListItemViewModel, ViewModel {

  private let subreddit: Subreddit

  var name: String {
    return subreddit.name
  }

  init(subreddit: Subreddit) {
    self.subreddit = subreddit
  }

}
