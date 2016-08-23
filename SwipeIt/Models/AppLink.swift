//
//  AppLink.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

struct AppLink {

  let appName: String
  let url: NSURL
  let appStoreId: String

  init?(html: String) {
    guard let parser = HTMLParser(html: html) else { return nil }

    guard let appName = parser.contentFromMetatag("al:ios:app_name"),
      appStoreId = parser.contentFromMetatag("al:ios:app_store_id"),
      urlString = parser.contentFromMetatag("al:ios:url"),
      url = NSURL(string: urlString) else {
        return nil
    }

    self.appName = appName
    self.url = url
    self.appStoreId = appStoreId
  }
}
