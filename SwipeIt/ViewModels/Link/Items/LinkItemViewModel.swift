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
  private let user: User
  private let accessToken: AccessToken
  private let vote: Variable<Vote>
  private let saved: Variable<Bool>
  private let showSubreddit: Bool

  // MARK: Protected
  let disposeBag: DisposeBag = DisposeBag()
  let link: Link

  // MARK: Calculated Properties
  var title: String {
    return link.title
  }

  var url: NSURL {
    return link.url
  }

  // MARK: Private Observables
  private var timeAgo: Observable<NSAttributedString> {
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

  // MARK: Observables
  var context: Observable<NSAttributedString?> {
    return Observable
      .combineLatest(timeAgo, subredditName, author) {
        let result: [NSAttributedString?] = [$0, $1, $2]
        return result.flatMap { $0 }
      }.map { (attributedStrings: [NSAttributedString]) in
        return attributedStrings.joinWithSeparator(" ● ")
    }
  }

  var comments: Observable<NSAttributedString> {
    let comments = link.totalComments > 1 ? tr(.LinkComments) : tr(.LinkComment)
    return .just(NSAttributedString(string: "\(link.totalComments) \(comments)"))
  }

  var commentsIcon: Observable<UIImage> {
    return .just(UIImage(asset: .CommentsGlyph))
  }

  var save: Observable<String> {
    return saved.asObservable()
      .map { $0 ? tr(.LinkUnsave) : tr(.LinkSave) }
  }

  var score: Observable<NSAttributedString> {
    return Observable
      .combineLatest(Observable.just(link), vote.asObservable()) { ($0, $1) }
      .map { (link, vote) in
        let score = link.hideScore == true ? tr(.LinkScoreHidden) : "\(link.scoreWithVote(vote))"
        switch vote {
        case .Downvote:
          return NSAttributedString(string: score,
            attributes: [NSForegroundColorAttributeName: UIColor(named: .Purple)])
        case .Upvote:
          return NSAttributedString(string: score,
            attributes: [NSForegroundColorAttributeName: UIColor(named: .Orange)])
        default:
          return NSAttributedString(string: score)
        }
    }
  }

  var scoreIcon: Observable<UIImage> {
    return  vote.asObservable()
      .map { vote in
        switch vote {
        case .Downvote:
          return UIImage(asset: .DownvotedGlyph)
        case .Upvote:
          return UIImage(asset: .UpvotedGlyph)
        case .None:
          return UIImage(asset: .NotVotedGlyph)
        }
    }
  }

  // MARK: Initializer
  init(user: User, accessToken: AccessToken, link: Link, showSubreddit: Bool) {
    self.user = user
    self.accessToken = accessToken
    self.link = link
    self.vote = Variable(link.vote)
    self.showSubreddit = showSubreddit
    self.saved = Variable(link.saved)
  }

  // MARK: API
  func preloadData() {
    // Nothing to preload in here
  }

  func upvote(completion: (ErrorType?) -> Void) {
    vote(.Upvote, completion: completion)
  }

  func downvote(completion: (ErrorType?) -> Void) {
    vote(.Downvote, completion: completion)
  }

  func unvote() {
    vote(.None)
  }

  func toggleSave(completion: (ErrorType?) -> Void) {
    save(completion)
  }

  func sendReport(reason: String, completion: (ErrorType?) -> Void) {
    report(reason, completion: completion)
  }
}

// MARK: Network
extension LinkItemViewModel {

  private func report(reason: String, completion: ((ErrorType?) -> Void)? = nil) {
    Network.request(.Report(token: accessToken.token, identifier: link.name,
      reason: reason))
      .subscribe { event in
        switch event {
        case .Error(let error):
          completion?(error)
        case .Next:
          completion?(nil)
        default: break
        }
      }.addDisposableTo(disposeBag)
  }

  private func save(completion: ((ErrorType?) -> Void)? = nil) {
    let oldSaved = self.saved.value
    self.saved.value = !oldSaved
    let request = oldSaved ? RedditAPI.Unsave(token: accessToken.token, identifier: link.name) :
      RedditAPI.Save(token: accessToken.token, identifier: link.name)
    Network.request(request)
      .subscribe { [weak self] event in
        switch event {
        case .Error(let error):
          self?.saved.value = oldSaved
          completion?(error)
        case .Next:
          completion?(nil)
        default: break
        }
      }.addDisposableTo(disposeBag)
  }

  private func vote(vote: Vote, completion: ((ErrorType?) -> Void)? = nil) {
    let oldVote = self.vote.value
    self.vote.value = vote
    Network.request(.Vote(token: accessToken.token, identifier: link.name,
      direction: vote.rawValue))
      .subscribe { [weak self] event in
        switch event {
        case .Error(let error):
          self?.vote.value = oldVote
          completion?(error)
        case .Next:
          completion?(nil)
        default: break
        }
      }.addDisposableTo(disposeBag)
  }
}

// MARK: Helpers
extension LinkItemViewModel {

  static func viewModelFromLink(link: Link, user: User, accessToken: AccessToken,
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
