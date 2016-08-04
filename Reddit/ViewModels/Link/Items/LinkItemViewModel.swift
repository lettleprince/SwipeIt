//
//  LinkItemViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import DateTools
import RxTimer

class LinkItemViewModel: ViewModel {

  // MARK: Private
  private let user: User?
  private let accessToken: AccessToken?
  private let vote: Variable<Vote>

  // MARK: Protected
  let disposeBag: DisposeBag = DisposeBag()
  let link: Link

  // MARK: Calculated Properties
  var title: String {
    return link.title
  }

  var subredditName: String {
    return link.subreddit
  }

  var author: String {
    return link.author
  }

  var totalComments: String {
    return "\(link.totalComments)"
  }

  var gilded: String {
    return "x\(link.gilded)"
  }

  var linkFlairText: String? {
    return link.linkFlairText
  }

  var authorFlairText: String? {
    return link.authorFlairText
  }

  var linkContext: [LinkContext] {
    var linkContext: [LinkContext] = [.TimeAgo, .Subreddit, .Author]

    if let authorFlairText = link.authorFlairText where authorFlairText.characters.count > 0 {
      linkContext.append(.AuthorFlair)
    }

    if let linkFlairText = link.linkFlairText where linkFlairText.characters.count > 0 {
      linkContext.append(.LinkFlair)
    }

    if link.gilded > 0 {
      linkContext.append(.Gold)
    }

    if link.stickied == true {
      linkContext.append(.Stickied)
    }

    if link.locked == true {
      linkContext.append(.Locked)
    }

    return linkContext
  }

  // MARK: Observables
  var timeAgo: Observable<String> {
    return Observable
      .combineLatest(Observable.just(link.created), NSTimer.rx_timer) { ($0, $1) }
      .map { (created, _) in
        created.shortTimeAgoSinceNow()
    }
  }

  var upvoted: Observable<Bool> {
    return vote.asObservable()
      .map { $0 == .Upvote }
  }

  var downvoted: Observable<Bool> {
    return vote.asObservable()
      .map { $0 == .Downvote }
  }

  var score: Observable<String> {
    return Observable
      .combineLatest(Observable.just(link), vote.asObservable()) { ($0, $1) }
      .map { (link, vote) in
        link.hideScore == true ? tr(.LinkScoreHidden) : "\(link.scoreWithVote(vote))"
    }
  }

  // MARK: Initializer
  init(user: User?, accessToken: AccessToken?, link: Link) {
    self.user = user
    self.accessToken = accessToken
    self.link = link
    self.vote = Variable(link.vote)

    setupObservers()
  }

  // MARK: Observers
  private func setupObservers() {
    setupVoteObserver()
  }

  private func setupVoteObserver() {
    let votes = Observable.zip(vote.asObservable().skip(1), vote.asObservable()) { ($0, $1) }
    Observable
      .combineLatest(Observable.just(accessToken).filterNil(), votes) { ($0, $1.0, $1.1) }
      .bindNext { [weak self] (accessToken, newVote, oldVote) in
        self?.vote(accessToken, oldVote: oldVote, newVote: newVote)
      }.addDisposableTo(disposeBag)
  }

  // MARK: API
  func preloadData() {
    // Nothing to preload in here
  }

  func upvote() {
    guard let _ = accessToken else { return }
    vote.value = vote.value == .Upvote ? .None : .Upvote
  }

  func downvote() {
    guard let _ = accessToken else { return }
    vote.value = vote.value == .Downvote ? .None : .Downvote
  }
}

// MARK: Network
extension LinkItemViewModel {

  private func vote(accessToken: AccessToken, oldVote: Vote, newVote: Vote) {
    Network.request(.Vote(token: accessToken.token, identifier: link.name,
      direction: newVote.rawValue)).debug()
      .subscribeError { [weak self] _ in
        self?.vote.value = oldVote
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Helpers
extension LinkItemViewModel {

  static func viewModelFromLink(link: Link, user: User?, accessToken: AccessToken?)
    -> LinkItemViewModel {
      switch link.type {
      case .Video:
        return LinkItemVideoViewModel(user: user, accessToken: accessToken, link: link)
      case .Image, .GIF, .Album:
        return LinkItemImageViewModel(user: user, accessToken: accessToken, link: link)
      case .SelfPost:
        return LinkItemSelfPostViewModel(user: user, accessToken: accessToken, link: link)
      case .LinkPost:
        return LinkItemLinkViewModel(user: user, accessToken: accessToken, link: link)
      }
  }
}
