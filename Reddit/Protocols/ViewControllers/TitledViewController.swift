//
//  TitledViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 03/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import NSObject_Rx

protocol TitledViewModelViewController: ViewModelViewController {

  func bindTitle()

}

extension TitledViewModelViewController
where Self: UIViewController, ViewModelType: TitledViewModel {

  func bindTitle() {
    viewModel.title
      .bindNext { [weak self] title in
      self?.title = title
    }.addDisposableTo(rx_disposeBag)
  }

}
