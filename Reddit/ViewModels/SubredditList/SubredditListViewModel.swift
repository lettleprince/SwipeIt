//
//  SubredditListViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional
import RxCocoa

// MARK: Properties and Initializer
class SubredditListViewModel: NSObject, ViewModel {

  private let user: User?
  private let accessToken: AccessToken?
  private let subredditListing: Variable<[SubredditListing]>

  var viewModels: Driver<[SubredditListItemViewModel]> {
    return subredditListing
      .asDriver()
      .map { subredditListings in
        subredditListings.flatMap { $0.subreddits }.flatten()
      }.map { subreddits in
        subreddits.map { SubredditListSubredditViewModel(subreddit: $0) }
      }.map { subredditViewModels in
        subredditViewModels.count == 0 ? self.defaultSubredditViewModels() : subredditViewModels
    }
  }

  init(user: User?, accessToken: AccessToken?) {
    self.user = user
    self.accessToken = accessToken
    subredditListing = Variable([])

    super.init()

    subredditListing
      .asDriver()
      .map { $0.last?.after }
      .driveNext { [weak self] after in
        self?.getSubreddits(after)
    }.addDisposableTo(rx_disposeBag)
  }

}

// MARK: Networking
extension SubredditListViewModel {

  func getSubreddits(after: String?) {
    guard let accessToken = accessToken else { return }

    Network.provider.request(.SubredditListing(token: accessToken.token, after: after))
      .mapObject(SubredditListing)
      .bindNext { [weak self] subredditListing in
        self?.subredditListing.value.append(subredditListing)
    }.addDisposableTo(rx_disposeBag)
  }

}

// MARK: Helpers
extension SubredditListViewModel {

  private func defaultSubredditViewModels() -> [SubredditListItemViewModel] {
    guard let path = NSBundle.mainBundle().pathForResource("DefaultSubreddits", ofType:"plist"),
      subredditNames = NSArray(contentsOfFile: path) as? [String]
      where accessToken == nil else {
        return []
    }
    return subredditNames.map { SubredditListNameViewModel(name: $0) }
  }

  private class func defaultSubredditNames() -> [String] {
    guard let path = NSBundle.mainBundle().pathForResource("DefaultSubreddits", ofType:"plist"),
      subredditNames = NSArray(contentsOfFile: path) as? [String] else {
      return []
    }
    return subredditNames
  }

}
