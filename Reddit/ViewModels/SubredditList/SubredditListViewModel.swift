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

// MARK: Properties and Initializer
class SubredditListViewModel: ViewModel {

  typealias SubredditListSectionViewModel = SectionViewModel<SubredditListItemViewModel>

  // MARK: Private Properties
  private let user: User?
  private let accessToken: AccessToken?
  private let subredditListings: Variable<[SubredditListing]>
  private let disposeBag = DisposeBag()

  // 1. Only send the signal when we have all listings
  // 2. Extract all subreddits into an array of subreddits
  // 3. Map subreddits into their view model
  // 4. Create sections from the subreddit view models
  var viewModels: Observable<[SubredditListSectionViewModel]> {
    return Observable.combineLatest(subredditViewModels, userObservable, accessTokenObservable) {
      ($0, $1, $2)
      }.map { (subredditViewModels: [SubredditListItemViewModel], user: User?,
        accessToken: AccessToken?) in
        SubredditListViewModel.sectionsFromSubredditViewModels(subredditViewModels, user: user,
          accessToken:  accessToken)
    }
  }

  init(user: User?, accessToken: AccessToken?) {
    self.user = user
    self.accessToken = accessToken

    subredditListings = Variable([])
  }
}

// MARK: Private Observables
extension SubredditListViewModel {

  private var subredditsObservable: Observable<[Subreddit]> {
    return subredditListings.asObservable()
      .filter { (subredditListing: [SubredditListing]) in
        return subredditListing.last?.after == nil && subredditListing.count > 0
      }.map { (subredditListings: [SubredditListing]) -> [Subreddit] in
        Array(subredditListings.flatMap { $0.subreddits }.flatten())
    }
  }

  private var userObservable: Observable<User?> {
    return .just(user)
  }

  private var accessTokenObservable: Observable<AccessToken?> {
    return .just(accessToken)
  }

  private var subredditViewModels: Observable<[SubredditListItemViewModel]> {
    return Observable.combineLatest(subredditsObservable, userObservable, accessTokenObservable) {
      ($0, $1, $2)
      }.map { (subreddits: [Subreddit], user: User?, accessToken: AccessToken?)
        -> [SubredditListItemViewModel] in
        return subreddits.map { subreddit in
          SubredditListSubredditViewModel(user: user, accessToken: accessToken,
            subreddit: subreddit)
        }
    }
  }
}

// MARK: Rx Bindings
extension SubredditListViewModel {

  // Load next subreddit listing either when we have 0 subreddit listings or
  // when the last subreddit listing has 'after'
  func requestAllSubreddits() {
    subredditListings
      .asDriver()
      .filter { $0.count == 0 || $0.last?.after != nil }
      .map { $0.last?.after }
      .driveNext { [weak self] after in
        self?.requestSubreddits(after)
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Networking
extension SubredditListViewModel {

  // Request default subreddits in case there is no accessToken, otherwise request user's subreddits
  private func requestSubreddits(after: String?) {
    var request: RedditAPI = .DefaultSubredditListing(after: after)

    if let accessToken = accessToken {
      request = .SubredditListing(token: accessToken.token, after: after)
    }

    Network.request(request)
      .mapObject(SubredditListing)
      .bindNext { [weak self] subredditListing in
        self?.subredditListings.value.append(subredditListing)
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Helpers
extension SubredditListViewModel {

  // Create the Frontpage and /r/all view models
  private class func specialSubredditViewModels(user: User?, accessToken: AccessToken?)
    -> [SubredditListItemViewModel] {
      let frontpage = SubredditListNameViewModel(user: user, accessToken: accessToken,
                                                 name: "Frontpage", path: "")
      let all = SubredditListNameViewModel(user: user, accessToken: accessToken,
                                           name: "All", path: "/r/all")
      return [frontpage, all]
  }

  // Extract first letters to create the alphabet, and create the sections afterwards
  // Add a ★ section for the Frontpage and /r/all
  private class func sectionsFromSubredditViewModels(viewModels: [SubredditListItemViewModel],
                                                     user: User?, accessToken: AccessToken?)
    -> [SubredditListSectionViewModel] {

      let alphabet = viewModels.map { $0.name.firstLetter }
        .unique()
        .sort(Sorter.alphabetSort)

      var sectionViewModels = [SectionViewModel(title: "★",
        viewModels: specialSubredditViewModels(user, accessToken: accessToken))]

      sectionViewModels += alphabet.map { letter in
        let viewModels = viewModels
          .filter { $0.name.firstLetter == letter }
          .sort { $0.0.name < $0.1.name }
        return SectionViewModel(title: letter, viewModels: viewModels)
      }

      return sectionViewModels
  }
}
