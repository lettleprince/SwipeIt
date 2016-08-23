//
//  LinkVideoViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializer
class LinkItemVideoViewModel: LinkItemViewModel {

  // MARK: Public Properties
  let imageURL: NSURL?
  let videoURL: NSURL

  override init(user: User, accessToken: AccessToken, link: Link, showSubreddit: Bool) {
    imageURL = link.imageURL
    videoURL = link.url
    super.init(user: user, accessToken: accessToken, link: link, showSubreddit: showSubreddit)
  }
}
