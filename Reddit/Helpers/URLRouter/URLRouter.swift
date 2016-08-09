//
//  URLRouter.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class URLRouter {

  static let sharedInstance = URLRouter()

  func openURL(URL: NSURL) -> Bool {
    return UIApplication.sharedApplication().openURL(URL)
  }

}
