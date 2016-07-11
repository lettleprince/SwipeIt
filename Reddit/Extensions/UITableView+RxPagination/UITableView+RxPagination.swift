//
//  UITableView+RxPagination.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift

// swiftlint:disable variable_name
extension UITableView {

  // sends signal when scroll pass the defined limit of offset
  // 2 pages before end of scroll
  // a page is defined by the height of the tableview
  var rx_paginate: Observable<Void> {
    return self.rx_contentOffset.filter { [weak self] contentOffset in
      guard let contentHeight = self?.contentSize.height,
        height = self?.bounds.height else {
          return false
      }
      let totalPages = Int(ceil(contentHeight / height))
      let currentPage = Int(ceil(contentOffset.y / height))
      return currentPage >= totalPages - 2
      }.map(void)
  }
}
