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
class LinkListViewModel {

  // MARK: Private Properties
  private let _title: String
  private let path: String
  private let user: User?
  private let accessToken: AccessToken?
  private let linkListings: Variable<[LinkListing]> = Variable([])
  private let _viewModels: Variable<[LinkListItemViewModel]> = Variable([])
  private let _listingType: Variable<ListingType> = Variable(.Hot)
  private let disposeBag = DisposeBag()

  // MARK: Initializer
  init(user: User?, accessToken: AccessToken?, title: String, path: String) {
    self.user = user
    self.accessToken = accessToken
    self._title = title
    self.path = path
  }

  convenience init(user: User?, accessToken: AccessToken?, subreddit: Subreddit) {
    self.init(user: user, accessToken: accessToken, title: subreddit.displayName,
              path: subreddit.path)
  }

  convenience init(user: User?, accessToken: AccessToken?, multireddit: Multireddit) {
    self.init(user: user, accessToken: accessToken, title: multireddit.name,
              path: multireddit.path)
  }
}

// MARK: Private Observables
extension LinkListViewModel {

  private var userObservable: Observable<User?> {
    return .just(user)
  }

  private var accessTokenObservable: Observable<AccessToken?> {
    return .just(accessToken)
  }

  private var afterObservable: Observable<String?> {
    return linkListings.asObservable()
      .map { $0.last?.after }
  }

  private var pathObservable: Observable<String> {
    return .just(path)
  }

  private var linksObservable: Observable<[Link]> {
    return linkListings.asObservable()
      .map { (linkListings: [LinkListing]) -> [Link] in
        Array(linkListings.flatMap { $0.links }.flatten())
    }
  }

  private var request: Observable<LinkListing> {
    return Observable
      .combineLatest(listingType, afterObservable, accessTokenObservable, pathObservable) {
      ($0, $1, $2, $3)
      }.take(1)
      .flatMap {
        (listingType: ListingType, after: String?, accessToken: AccessToken?, path: String) in
        Network.request(RedditAPI.LinkListing(token: accessToken?.token,
          path: path, listingPath: listingType.path, after: after))
      }.mapObject(LinkListing)
  }
}

// MARK: Public API
extension LinkListViewModel {

  var viewModels: Observable<[LinkListItemViewModel]> {
    return _viewModels.asObservable()
  }

  var listingType: Observable<ListingType> {
    return _listingType.asObservable()
  }

  func viewModelForIndex(index: Int) -> LinkListItemViewModel? {
    return _viewModels.value.get(index)
  }

  func requestLinks() {
    Observable.combineLatest(request, userObservable, accessTokenObservable) {
      ($0, $1, $2)
      }.take(1)
      .bindNext { [weak self] (linkListing, user, accessToken) in
        self?.linkListings.value.append(linkListing)
        let viewModels = LinkListViewModel.viewModelsFromLinkListing(linkListing,
          user: user, accessToken: accessToken)
        viewModels.forEach { $0.preloadData() }
        self?._viewModels.value += viewModels
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Helpers
extension LinkListViewModel {

  private static func viewModelFromLink(link: Link, user: User?, accessToken: AccessToken?)
    -> LinkListItemViewModel {
      switch link.type {
      case .Video:
        return LinkListVideoViewModel(user: user, accessToken: accessToken, link: link)
      case .Image, .Album:
        return LinkListImageViewModel(user: user, accessToken: accessToken, link: link)
      case .SelfPost:
        return LinkListSelfPostViewModel(user: user, accessToken: accessToken, link: link)
      case .LinkPost:
        return LinkListLinkViewModel(user: user, accessToken: accessToken, link: link)
      }
  }

  private static func viewModelsFromLinkListing(linkListing: LinkListing, user: User?,
                                                accessToken: AccessToken?)
    -> [LinkListItemViewModel] {
      return linkListing.links.map { links in
        LinkListViewModel.viewModelFromLink(links, user: user, accessToken: accessToken)
      }
  }
}

// MARK: TitledViewModel
extension LinkListViewModel: TitledViewModel {

  var title: Observable<String> {
    return .just(_title)
  }
}
