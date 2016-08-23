//
//  LoadingState.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

// MARK: - Enum Values
enum LoadingState: Equatable {

  /// Content is available and not loading any content
  case Normal
  /// No Content is available
  case Empty
  /// Got an error loading content
  case Error
  /// Is loading content
  case Loading
}

// MARK: - Equatable
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
