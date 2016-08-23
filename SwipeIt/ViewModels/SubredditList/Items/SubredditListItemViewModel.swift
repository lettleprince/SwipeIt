//
//  SubredditListItemViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// Protocol to wrap both SubredditListNameViewModel and SubredditListSubredditViewModel
protocol SubredditListItemViewModel: ViewModel {

  var name: String { get }
  var linkSwipeViewModel: LinkSwipeViewModel { get }
}
