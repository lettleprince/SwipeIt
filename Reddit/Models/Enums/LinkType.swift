//
//  LinkType.swift
//  Reddit
//
//  Created by Ivan Bruel on 18/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

enum LinkType: Equatable {

  case Video
  case Image
  case GIF
  case Album
  case SelfPost
  case LinkPost
}

extension LinkType {

  static func typeFromLink(link: Link) -> LinkType {
    if link.selfPost == true && link.selfText != nil {
      return .SelfPost
    } else if link.media?.type == "video" {
      return .Video
    } else if link.media?.type == "rich" {
      return .Album
    } else if link.imageURL != nil {
      return link.imageURL?.pathExtension == ".gif" ? .GIF : .Image
    } else {
      return .LinkPost
    }
  }
}

func == (lhs: LinkType, rhs: LinkType) -> Bool {
  switch (lhs, rhs) {
  case (.Video, .Video):
    return true
  case (.Image, .Image):
    return true
  case (.Album, .Album):
    return true
  case (.SelfPost, .SelfPost):
    return true
  case (.LinkPost, .LinkPost):
    return true
  case (.GIF, .GIF):
    return true
  default:
    return false
  }
}
