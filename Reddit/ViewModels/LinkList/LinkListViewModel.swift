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
}

// MARK: Public Observables
extension LinkListViewModel {

  var listingType: Observable<ListingType> {
    return _listingType.asObservable()
  }

  // TODO: Fix view model reusage (OpenGraph problem)
  var viewModels: Observable<[LinkListItemViewModel]> {
    let linksObservable = linkListings.asObservable()
      .map { (linkListings: [LinkListing]) -> [Link] in
        Array(linkListings.flatMap { $0.links }.flatten())
    }
    return Observable.combineLatest(userObservable, accessTokenObservable, linksObservable) {
      ($0, $1, $2)
      }.map { (user: User?, accessToken: AccessToken?, links: [Link]) in
        links.map { links in
          LinkListViewModel.viewModelFromLink(links, user: user, accessToken: accessToken)
        }
    }
  }

  func requestLinks() {
    Observable.combineLatest(listingType, afterObservable, accessTokenObservable, pathObservable) {
      ($0, $1, $2, $3)
      }.take(1)
      .flatMap {
        (listingType: ListingType, after: String?, accessToken: AccessToken?, path: String) in
        Network.provider.request(RedditAPI.LinkListing(token: accessToken?.token,
          path: path, listingPath: listingType.path, after: after))
      }.mapObject(LinkListing)
      .bindNext { [weak self] linkListing in
        self?.linkListings.value.append(linkListing)
      }.addDisposableTo(disposeBag)
  }

  static func viewModelFromLink(link: Link, user: User?, accessToken: AccessToken?)
    -> LinkListItemViewModel {
      switch link.type {
      case .Video:
        return LinkListVideoViewModel(user: user, accessToken: accessToken, link: link)
      case .Image:
        return LinkListImageViewModel(user: user, accessToken: accessToken, link: link)
      case .SelfPost:
        return LinkListSelfPostViewModel(user: user, accessToken: accessToken, link: link)
      case .LinkPost:
        return LinkListLinkViewModel(user: user, accessToken: accessToken, link: link)
      }
  }
}


// MARK: TitledViewModel
extension LinkListViewModel: TitledViewModel {

  var title: Observable<String> {
    return .just(_title)
  }
}
