//
//  LinkItemSelfPostViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift
import MarkdownKit

// MARK: Properties and initializer
class LinkItemSelfPostViewModel: LinkItemViewModel {

  private static let markdownParser =
    MarkdownParser(customElements: [MarkdownUser(), MarkdownSubreddit()])

  let selfText: NSAttributedString

  override init(user: User?, accessToken: AccessToken?, link: Link, showSubreddit: Bool) {
    selfText = LinkItemSelfPostViewModel.attributedSelfText(link)
    super.init(user: user, accessToken: accessToken, link: link, showSubreddit: showSubreddit)
  }
}

extension LinkItemSelfPostViewModel {

  private static func attributedSelfText(link: Link) -> NSAttributedString {
    guard let selfText = link.selfText else {
      return NSAttributedString(string: "")
    }
    return LinkItemSelfPostViewModel.markdownParser.parse(selfText.stringByDecodingHTMLEntities)
  }
}
