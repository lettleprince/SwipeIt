//
//  LoadingState.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum LoadingState: Equatable {
  case Normal
  case Empty
  case Error
  case Loading
}

func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
  switch (lhs, rhs) {
  case (.Normal, .Normal):
    return true
  case (.Empty, .Empty):
    return true
  case (.Error, .Error):
    return true
  case (.Loading, .Loading):
    return true
  default:
    return false
  }
}
