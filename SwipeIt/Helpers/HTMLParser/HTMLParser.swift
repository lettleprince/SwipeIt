//
//  HTMLParser.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Kanna

class HTMLParser {

  private let document: HTMLDocument

  init?(html: String) {
    guard let document = Kanna.HTML(html: html, encoding: NSUTF8StringEncoding) else { return nil }

    self.document = document
  }

  func contentFromMetatag(metatag: String) -> String? {
    return document.head?.xpath(xpathForMetatag(metatag)).first?["content"]
  }

  private func xpathForMetatag(metatag: String) -> String {
    return "//meta[@property='\(metatag)'] | //meta[@name='\(metatag)']"
  }
}
