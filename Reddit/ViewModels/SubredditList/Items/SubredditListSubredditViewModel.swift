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
class SubredditListSubredditViewModel: NSObject, SubredditListItemViewModel {

  private let subreddit: Subreddit

  var name: String {
    return subreddit.displayName
  }

  init(subreddit: Subreddit) {
    self.subreddit = subreddit
  }

}
