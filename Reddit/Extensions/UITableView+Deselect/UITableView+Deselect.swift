//
//  UITableView+Deselect.swift
//  Reddit
//
//  Created by Ivan Bruel on 11/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension UITableView {

  func deselectRows(animated: Bool) {
    indexPathsForSelectedRows?.forEach {
      self.deselectRowAtIndexPath($0, animated: animated)
    }
  }
}
