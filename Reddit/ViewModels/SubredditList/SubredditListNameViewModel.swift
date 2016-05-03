//
//  SubredditViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and Initializer
class SubredditListNameViewModel: SubredditListItemViewModel, ViewModel {

  let name: String

  init(name: String) {
    self.name = name
  }

}
