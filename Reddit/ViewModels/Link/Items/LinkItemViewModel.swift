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
import TTTAttributedLabel

class LinkItemViewModel: ViewModel {

  // MARK: Private
  private let user: User?
  private let accessToken: AccessToken?
  private let vote: Variable<Vote>
  private let showSubreddit: Bool

  // MARK: Protected
  let disposeBag: DisposeBag = DisposeBag()
  let link: Link

  // MARK: Calculated Properties
  var title: String {
    return link.title
  }

  var totalComments: String {
    return "\(link.totalComments)"
  }

  // MARK: Private Observables
  var timeAgo: Observable<NSAttributedString> {
    return Observable
      .combineLatest(Observable.just(link.created), NSTimer.rx_timer) { ($0, $1) }
      .map { (created, _) -> String in
        created.shortTimeAgoSinceNow()
      }.distinctUntilChanged()
      .map { NSAttributedString(string: $0) }
  }

  private var subredditName: Observable<NSAttributedString?> {
    return Observable.just(showSubreddit ? NSAttributedString(string: link.subreddit,
      attributes: [NSLinkAttributeName: link.subredditURL]) : nil)
  }

  private var author: Observable<NSAttributedString> {
    return Observable.just(NSAttributedString(string: link.author,
      attributes: [NSLinkAttributeName: link.authorURL]))
  }

  private var gilded: Observable<NSAttributedString?> {
    let gildedString: String? = link.gilded > 0 ? "x\(link.gilded)" : nil
    return Observable.just(gildedString.map { NSAttributedString(string: $0) })
  }

  private var linkFlairText: Observable<NSAttributedString?> {
    return Observable
      .combineLatest(Observable.just(link.linkFlairText),
      Theming.sharedInstance.accentColor, Theming.sharedInstance.backgroundColor) { ($0, $1, $2) }
      .map { (text, accentColor, backgroundColor) in
        guard text?.characters.count > 0 else { return nil }
        return text.map { NSAttributedString(string: " \($0) ",
          attributes: [LinkView.tagAttributeName: true]) }
    }
  }


  private var authorFlairText: Observable<NSAttributedString?> {
    return Observable
      .combineLatest(Observable.just(link.authorFlairText),
      Theming.sharedInstance.accentColor, Theming.sharedInstance.backgroundColor) { ($0, $1, $2) }
      .map { (text, accentColor, backgroundColor) in
        guard text?.characters.count > 0 else { return nil }
        return text.map { NSAttributedString(string: " \($0) ",
          attributes: [LinkView.tagAttributeName: true]) }
    }
  }

  private var stickied: Observable<NSAttributedString?> {
    let stickiedString: String? = link.stickied == true ? tr(.LinkContextStickied) : nil
    return Observable.just(stickiedString.map { NSAttributedString(string: $0) })
  }

  private var locked: Observable<NSAttributedString?> {
    let lockedString: String? = link.locked == true ? tr(.LinkContextLocked) : nil
    return Observable.just(lockedString.map { NSAttributedString(string: $0) })
  }

  // MARK: Observables
  var contextAttributedString: Observable<NSAttributedString> {
    return Observable
      .combineLatest(timeAgo, subredditName, author, authorFlairText, linkFlairText, gilded,
      stickied, locked) {
        let result: [NSAttributedString?] = [$0, $1, $2, $3, $4, $5, $6, $7]
        return result.flatMap { $0 }
      }
      .map { (attributedStrings: [NSAttributedString]) in
        let separator = NSAttributedString(string: " ● ")
        return attributedStrings.joinWithSeparator(separator)
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
  init(user: User?, accessToken: AccessToken?, link: Link, showSubreddit: Bool) {
    self.user = user
    self.accessToken = accessToken
    self.link = link
    self.vote = Variable(link.vote)
    self.showSubreddit = showSubreddit

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
      direction: newVote.rawValue))
      .subscribeError { [weak self] _ in
        self?.vote.value = oldVote
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Helpers
extension LinkItemViewModel {

  static func viewModelFromLink(link: Link, user: User?, accessToken: AccessToken?,
                                subredditOnly: Bool) -> LinkItemViewModel {
      switch link.type {
      case .Video:
        return LinkItemVideoViewModel(user: user, accessToken: accessToken, link: link,
                                      showSubreddit: !subredditOnly)
      case .Image, .GIF, .Album:
        return LinkItemImageViewModel(user: user, accessToken: accessToken, link: link,
                                      showSubreddit: !subredditOnly)
      case .SelfPost:
        return LinkItemSelfPostViewModel(user: user, accessToken: accessToken, link: link,
                                         showSubreddit: !subredditOnly)
      case .LinkPost:
        return LinkItemLinkViewModel(user: user, accessToken: accessToken, link: link,
                                     showSubreddit: !subredditOnly)
      }
  }
}
