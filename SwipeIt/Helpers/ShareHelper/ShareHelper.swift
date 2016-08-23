//
//  ShareHelper.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class ShareHelper {

  private let viewController: UIViewController

  init(viewController: UIViewController) {
    self.viewController = viewController
  }


  func share(text: String? = nil, URL: NSURL? = nil, image: UIImage? = nil,
             fromView: UIView? = nil) {
    let shareables: [AnyObject?] = [text, URL, image]

    let activityViewController = UIActivityViewController(activityItems: shareables.flatMap { $0 },
                                                          applicationActivities: nil)

    activityViewController.excludedActivityTypes = [UIActivityTypeAirDrop,
                                                    UIActivityTypeOpenInIBooks]

    activityViewController.popoverPresentationController?.sourceView = fromView
    viewController.presentViewController(activityViewController, animated: true, completion: nil)
  }
}
