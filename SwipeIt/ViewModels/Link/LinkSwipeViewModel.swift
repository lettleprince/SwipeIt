//
//  SubredditLinkListViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializer
class LinkSwipeViewModel {

  // MARK: Private Properties
  private let _title: String
  private let path: String
  private let subredditOnly: Bool
  private let user: User
  private let accessToken: AccessToken
  private let linkListings: Variable<[LinkListing]> = Variable([])
  private let _viewModels: Variable<[LinkItemViewModel]> = Variable([])
  private let _listingType: Variable<ListingType> = Variable(.Hot)
  private var disposeBag = DisposeBag()
  private let _loadingState = Variable<LoadingState>(.Normal)

  // MARK: Initializer
  init(user: User, accessToken: AccessToken, title: String, path: String, subredditOnly: Bool) {
    self.user = user
    self.accessToken = accessToken
    self._title = title
    self.path = path
    self.subredditOnly = subredditOnly
  }

  convenience init(user: User, accessToken: AccessToken, subreddit: Subreddit) {
    self.init(user: user, accessToken: accessToken, title: subreddit.displayName,
              path: subreddit.path, subredditOnly: true)
  }

  convenience init(user: User, accessToken: AccessToken, multireddit: Multireddit) {
    self.init(user: user, accessToken: accessToken, title: multireddit.name,
              path: multireddit.path, subredditOnly: false)
  }
}

// MARK: Private Observables
extension LinkSwipeViewModel {

  private var userObservable: Observable<User> {
    return .just(user)
  }

  private var accessTokenObservable: Observable<AccessToken> {
    return .just(accessToken)
  }

  private var afterObservable: Observable<String?> {
    return linkListings.asObservable()
      .map { $0.last?.after }
  }

  private var listingTypeObservable: Observable<ListingType> {
    return _listingType.asObservable()
  }

  private var pathObservable: Observable<String> {
    return .just(path)
  }

  private var subredditOnlyObservable: Observable<Bool> {
    return .just(subredditOnly)
  }

  private var request: Observable<LinkListing> {
    return Observable
      .combineLatest(listingTypeObservable, afterObservable, accessTokenObservable,
        pathObservable) { ($0, $1, $2, $3) }
      .take(1)
      .doOnNext { [weak self] _ in
        self?._loadingState.value = .Loading
      }.flatMap {
        (listingType: ListingType, after: String?, accessToken: AccessToken, path: String) in
        Network.request(RedditAPI.LinkListing(token: accessToken.token,
          path: path, listingPath: listingType.path, listingTypeRange: listingType.range?.rawValue,
          after: after))
      }.observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
      .mapObject(LinkListing)
      .observeOn(MainScheduler.instance)
  }
}

// MARK: Public API
extension LinkSwipeViewModel {

  var viewModels: Observable<[LinkItemViewModel]> {
    return _viewModels.asObservable()
  }

  var loadingState: Observable<LoadingState> {
    return _loadingState.asObservable()
  }

  var listingTypeName: Observable<String> {
    return _listingType.asObservable()
      .map { $0.name }
  }

  func viewModelForIndex(index: Int) -> LinkItemViewModel? {
    return _viewModels.value.get(index)
  }

  func requestLinks() {
    guard _loadingState.value != .Loading else { print("still loading")
      return }

    Observable
      .combineLatest(request, userObservable, accessTokenObservable, subredditOnlyObservable) {
        ($0, $1, $2, $3)
      }.take(1)
      .subscribe { [weak self] event in
        guard let `self` = self else { return }

        switch event {
        case let .Next(linkListing, user, accessToken, subredditOnly):
          print("loaded \(linkListing.after)")
          self.linkListings.value.append(linkListing)
          let viewModels = LinkSwipeViewModel.viewModelsFromLinkListing(linkListing,
            user: user, accessToken: accessToken, subredditOnly: subredditOnly)
          viewModels.forEach { $0.preloadData() }
          self._loadingState.value = self._viewModels.value.count > 0 ? .Normal : .Empty
          self._viewModels.value += viewModels
        case .Error:
          self._loadingState.value = .Error
        default: break
        }

      }.addDisposableTo(disposeBag)
  }

  func setListingType(listingType: ListingType) {
    guard listingType != _listingType.value else { return }
    _listingType.value = listingType
    refresh()
  }

  func refresh() {
    linkListings.value = []
    _viewModels.value = []
    disposeBag = DisposeBag()
    _loadingState.value = .Normal
    requestLinks()
  }
}

// MARK: Helpers
extension LinkSwipeViewModel {

  private static func viewModelsFromLinkListing(linkListing: LinkListing, user: User,
                                                accessToken: AccessToken, subredditOnly: Bool)
    -> [LinkItemViewModel] {
      return linkListing.links
        .filter { link in
          let vote: Vote = link.vote
          return !link.stickied && vote == .None
        }.map { LinkItemViewModel.viewModelFromLink($0, user: user, accessToken: accessToken,
          subredditOnly: subredditOnly)
      }
  }
}

// MARK: TitledViewModel
extension LinkSwipeViewModel: TitledViewModel {

  var title: Observable<String> {
    return .just(_title)
  }
}
