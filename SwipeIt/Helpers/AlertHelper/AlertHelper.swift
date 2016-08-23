//
//  AlertHelper.swift
//  Reddit
//
//  Created by Ivan Bruel on 05/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class AlertHelper {

  private let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }

  func presentActionSheet(title: String? = nil, message: String? = nil, options: [String],
                          clicked: (Int?) -> Void) {
    let alertController = UIAlertController(title: title, message: message,
                                            preferredStyle: .ActionSheet)

    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { action in
      clicked(nil)
    }
    alertController.addAction(cancelAction)

    (0..<options.count).forEach { index in
      let action = UIAlertAction(title: options[index], style: .Default) { action in
        clicked(index)
      }
      alertController.addAction(action)
    }

    viewController.presentViewController(alertController, animated: true, completion: nil)
  }
}
