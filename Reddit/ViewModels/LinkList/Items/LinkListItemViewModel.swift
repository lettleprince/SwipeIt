//
//  LinkListItemViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import DateTools

protocol LinkListItemViewModel: class, ViewModel {

  // MARK: Private
  var user: User? { get }
  var accessToken: AccessToken? { get }
  var link: Link { get }
  var disposeBag: DisposeBag { get }

  // MARK: Public
  var vote: Variable<Vote> { get }
  var title: String { get }
  var subredditName: String { get }
  var author: String { get }
  var totalComments: String { get }
  var timeAgo: Observable<String> { get }
  var upvoted: Observable<Bool> { get }
  var downvoted: Observable<Bool> { get }
  var score: Observable<String> { get }
  var gilded: String { get }
  var linkContext: [LinkContext] { get }

  func preloadData()
  func upvote()
  func downvote()
  func setupObservers()
}

extension LinkListItemViewModel {

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

  var linkContext: [LinkContext] {
    var linkContext: [LinkContext] = [.TimeAgo, .Subreddit, .Author]
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

  var timeAgo: Observable<String> {
    let timer = Observable<Void>.create { observer in
      observer.onNext()
      let timer = NSTimer.schedule(repeatInterval: 1.0) { timer in
        observer.onNext()
      }
      return AnonymousDisposable {
        observer.onCompleted()
        timer.invalidate()
      }
    }
    return Observable
      .combineLatest(Observable.just(link.created), timer) { ($0, $1) }
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

  func setupObservers() {
    let votes = Observable.zip(vote.asObservable().skip(1), vote.asObservable()) { ($0, $1) }
    Observable
      .combineLatest(Observable.just(accessToken).filterNil(), votes) { ($0, $1.0, $1.1) }
      .bindNext { [weak self] (accessToken, oldVote, newVote) in
        self?.vote(accessToken, oldVote: oldVote, newVote: newVote)
    }.addDisposableTo(disposeBag)
  }

  func preloadData() { }

  func upvote() {
    guard let _ = accessToken else { return }
    vote.value = vote.value == .Upvote ? .None : .Upvote
  }

  func downvote() {
    guard let _ = accessToken else { return }
    vote.value = vote.value == .Downvote ? .None : .Downvote
  }

  private func vote(accessToken: AccessToken?, oldVote: Vote, newVote: Vote) {
    guard let accessToken = accessToken else { return }
    Network.request(.Vote(token: accessToken.token, identifier: link.identifier,
      direction: newVote.rawValue))
      .subscribeError { [weak self] _ in
        self?.vote.value = oldVote

    }.addDisposableTo(disposeBag)
  }
}
