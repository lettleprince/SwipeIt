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

  func subredditURL(subredditName: String) -> NSURL {
    return NSURL(string: "\(Constants.redditURL)/r/\(subredditName)")!
  }

  func userURL(username: String) -> NSURL {
    return NSURL(string: "\(Constants.redditURL)/u/\(username)")!
  }

  func openURL(URL: NSURL) -> Bool {
    return UIApplication.sharedApplication().openURL(URL)
  }

}
