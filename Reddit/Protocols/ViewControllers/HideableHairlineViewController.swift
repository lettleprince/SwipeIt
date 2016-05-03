//
//  HideableHairlineViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

protocol HideableHairlineViewController {

  func hideHairline()
  func showHairline()

}

extension HideableHairlineViewController where Self: UIViewController {

  func hideHairline() {
    findHairline()?.hidden = true
  }

  func showHairline() {
    findHairline()?.hidden = false
  }

  private func findHairline() -> UIImageView? {
    return navigationController?.navigationBar.subviews
      .flatMap { $0.subviews }
      .flatMap { $0 as? UIImageView }
      .filter { $0.bounds.size.width == self.navigationController?.navigationBar.bounds.size.width }
      .filter { $0.bounds.size.height <= 2 }
      .first
  }

}
