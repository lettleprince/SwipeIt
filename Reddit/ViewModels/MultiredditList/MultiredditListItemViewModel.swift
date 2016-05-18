//
//  MultiredditListItemViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class MultiredditListItemViewModel: ViewModel {

  private let multireddit: Multireddit

  let name: String
  let subreddits: String

  init(multireddit: Multireddit) {
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
