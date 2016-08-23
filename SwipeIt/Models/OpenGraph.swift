//
//  OpenGraph.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

struct OpenGraph {

  let description: String?
  let title: String
  let imageURL: NSURL?
  let appLink: AppLink?

  // MARK: HTML
  init?(html: String) {
    guard let parser = HTMLParser(html: html) else { return nil }

    guard let titleMeta = parser.contentFromMetatag("og:title") else {
      return nil
    }

    title = titleMeta
    description = parser.contentFromMetatag("og:description")

    if let imageMeta = parser.contentFromMetatag("og:image") {
      imageURL = NSURL(string: imageMeta)
    } else {
      imageURL = nil
    }

    appLink = AppLink(html: html)
  }
}
