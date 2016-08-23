//
//  MultiredditListItemViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class MultiredditListItemViewModel: ViewModel {

  // MARK: Private Properties
  private let user: User
  private let accessToken: AccessToken
  private let multireddit: Multireddit

  let name: String
  let subreddits: String

  var linkSwipeViewModel: LinkSwipeViewModel {
    return LinkSwipeViewModel(user: user, accessToken: accessToken, multireddit: multireddit)
  }

  init(user: User, accessToken: AccessToken, multireddit: Multireddit) {
    self.user = user
    self.accessToken = accessToken
    self.multireddit = multireddit

    name = multireddit.name
    subreddits = MultiredditListItemViewModel.subredditString(multireddit.subreddits)
  }

}

// MARK: Helpers
extension MultiredditListItemViewModel {

  private class func subredditString(subreddits: [String]) -> String {
    switch subreddits.count {
    case 0..<4:
      return subreddits.joinWithSeparator(", ")
    default:
      return "\(subreddits.count) subreddits"
    }
  }
}
