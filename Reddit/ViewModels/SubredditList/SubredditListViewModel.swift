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

  typealias SubredditListSectionViewModel = SectionViewModel<SubredditListItemViewModel>

  // MARK: Private Properties
  private let user: User?
  private let accessToken: AccessToken?
  private let subredditListings: Variable<[SubredditListing]>

  // 1. Only send the signal when we have all listings
  // 2. Extract all subreddits into an array of subreddits
  // 3. Map subreddits into their view model
  // 4. Create sections from the subreddit view models
  var viewModels: Observable<[SubredditListSectionViewModel]> {
    return subredditListings.asObservable()
      .filter { (subredditListing: [SubredditListing]) in
        return subredditListing.last?.after == nil && subredditListing.count > 0
      }.map { (subredditListings: [SubredditListing]) -> [Subreddit] in
        Array(subredditListings.flatMap { $0.subreddits }.flatten())
      }.map { (subreddits: [Subreddit]) -> [SubredditListItemViewModel] in
        subreddits.map { SubredditListSubredditViewModel(subreddit: $0) }
      }.map { subredditViewModels in
        return SubredditListViewModel.sectionsFromSubredditViewModels(subredditViewModels)
    }
  }

  init(user: User?, accessToken: AccessToken?) {
    self.user = user
    self.accessToken = accessToken

    subredditListings = Variable([])

    super.init()

    requestAllSubreddits()
  }
}

// MARK: Rx Bindings
extension SubredditListViewModel {

  // Load next subreddit listing either when we have 0 subreddit listings or
  // when the last subreddit listing has 'after'
  private func requestAllSubreddits() {
    subredditListings
      .asDriver()
      .filter { $0.count == 0 || $0.last?.after != nil }
      .map { $0.last?.after }
      .driveNext { [weak self] after in
        self?.requestSubreddits(after)
      }.addDisposableTo(rx_disposeBag)
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

    Network.provider.request(request)
      .mapObject(SubredditListing)
      .bindNext { [weak self] subredditListing in
        self?.subredditListings.value.append(subredditListing)
      }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: Helpers
extension SubredditListViewModel {

  // Create the Frontpage and /r/all view models
  private class func specialSubredditViewModels() -> [SubredditListItemViewModel] {
    return [SubredditListNameViewModel(name: "Frontpage"), SubredditListNameViewModel(name: "All")]
  }

  // Extract first letters to create the alphabet, and create the sections afterwards
  // Add a ★ section for the Frontpage and /r/all
  private class func sectionsFromSubredditViewModels(viewModels: [SubredditListItemViewModel])
    -> [SubredditListSectionViewModel] {

      let alphabet = viewModels.map { $0.name.firstLetter }
        .unique()
        .sort(Sorter.alphabetSort)

      var sectionViewModels = [SectionViewModel(title: "★",
        viewModels: specialSubredditViewModels())]

      sectionViewModels += alphabet.map { letter in
        let viewModels = viewModels
          .filter { $0.name.firstLetter == letter }
          .sort { $0.0.name < $0.1.name }
        return SectionViewModel(title: letter, viewModels: viewModels)
      }
      return sectionViewModels
  }

}
