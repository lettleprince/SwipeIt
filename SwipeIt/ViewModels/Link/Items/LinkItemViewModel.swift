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
      }
      .map { (attributedStrings: [NSAttributedString]) in
        let separator = NSAttributedString(string: " ● ")
        return attributedStrings.joinWithSeparator(separator)
    }
  }

  var comments: Observable<NSAttributedString> {
    return .just(NSAttributedString(string: "\(link.totalComments)",
      attributes: [NSForegroundColorAttributeName: UIColor(named: .DarkGray)]))
  }

  var commentsIcon: Observable<UIImage> {
    return .just(UIImage(asset: .CommentsGlyph))
  }

  var score: Observable<NSAttributedString> {
    return Observable
      .combineLatest(Observable.just(link), vote.asObservable()) { ($0, $1) }
      .map { (link, vote) in
        let score = link.hideScore == true ? tr(.LinkScoreHidden) : "\(link.scoreWithVote(vote))"
        let color: UIColor
        switch vote {
        case .Downvote:
          color = UIColor(named: .Purple)
        case .Upvote:
          color = UIColor(named: .Orange)
        case .None:
          color = UIColor(named: .DarkGray)
        }
        return NSAttributedString(string: score,
          attributes: [NSForegroundColorAttributeName: color])
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
}

// MARK: Network
extension LinkItemViewModel {

  private func vote(vote: Vote, completion: ((ErrorType?) -> Void)? = nil) {
    self.vote.value = vote
    Network.request(.Vote(token: accessToken.token, identifier: link.name,
      direction: vote.rawValue))
      .subscribe { [weak self] event in
        switch event {
        case .Error(let error):
          self?.vote.value = .None
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
