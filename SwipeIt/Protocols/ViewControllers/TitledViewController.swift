//
//  TitledViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 03/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import NSObject_Rx

protocol TitledViewModelViewController {

  func bindTitle(viewModel: TitledViewModel)

}

extension TitledViewModelViewController where Self: UIViewController {

  func bindTitle(viewModel: TitledViewModel) {
    viewModel.title
      .bindNext { [weak self] title in
      self?.title = title
    }.addDisposableTo(rx_disposeBag)
  }
}
