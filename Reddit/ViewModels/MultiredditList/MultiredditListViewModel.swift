//
//  MultiredditListViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional
import RxCocoa

// MARK: Properties and Initializer
class MultiredditListViewModel: NSObject, ViewModel {

  typealias MultiredditListSectionViewModel = SectionViewModel<MultiredditListItemViewModel>

  // MARK: Private Properties
  private let user: User?
  private let accessToken: AccessToken?
  private let multireddits: Variable<[Multireddit]>

  // 1. Map multireddits into their view model
  // 4. Create sections from the subreddit view models
  var viewModels: Observable<[MultiredditListSectionViewModel]> {
    return multireddits.asObservable()
      .map { (multireddits: [Multireddit]) -> [MultiredditListItemViewModel] in
        multireddits.map { MultiredditListItemViewModel(multireddit: $0) }
      }.map { multiredditViewModels in
        return MultiredditListViewModel.sectionsFromMultiredditViewModels(multiredditViewModels)
    }
  }

  init(user: User?, accessToken: AccessToken?) {
    self.user = user
    self.accessToken = accessToken

    multireddits = Variable([])

    super.init()

    requestMultireddits()
  }
}

// MARK: Networking
extension MultiredditListViewModel {

  private func requestMultireddits() {
    guard let accessToken = accessToken else { return }

    Network.provider.request(.MultiredditListing(token: accessToken.token))
      .mapArray(Multireddit)
      .bindNext { [weak self] multireddits in
        self?.multireddits.value = multireddits
      }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: Helpers
extension MultiredditListViewModel {

  // Extract first letters to create the alphabet, and create the sections afterwards
  private class func sectionsFromMultiredditViewModels(viewModels: [MultiredditListItemViewModel])
    -> [MultiredditListSectionViewModel] {

      return viewModels.map { $0.name.firstLetter }
        .unique()
        .sort(Sorter.alphabetSort)
        .map { letter in
          let viewModels = viewModels
            .filter { $0.name.firstLetter == letter }
            .sort { $0.0.name < $0.1.name }
          return SectionViewModel(title: letter, viewModels: viewModels)
      }
  }
}
