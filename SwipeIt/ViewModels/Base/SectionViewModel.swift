//
//  SubredditListSectionViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxDataSources

// Generic Section View Model for ViewModel implementations
final class SectionViewModel<T>: ViewModel {

  let title: String
  let viewModels: [T]

  init(title: String, viewModels: [T]) {
    self.title = title
    self.viewModels = viewModels
  }

}

extension SectionViewModel: SectionModelType {
  typealias Item = T

  var items: [Item] {
    return viewModels
  }

  convenience init(original: SectionViewModel, items: [Item]) {
    self.init(title: original.title, viewModels: items)
  }
}
