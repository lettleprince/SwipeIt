//
//  UIStoryboardSegue+Naxigation.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {

  var navigationRootViewController: UIViewController? {
    guard let navigationController = destinationViewController as? UINavigationController else {
      return nil
    }
    return navigationController.viewControllers.first
  }

}
