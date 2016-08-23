//
//  ImgurImageProvider.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class ImgurImageProvider: ImageProvider {

  private static let regex = "^https?://.*imgur.com/(?!a/)(?!gallery/)(\\w)+"
  private static let extensionRegex = "(.jpe?g|.png|.gif)$"


  static func imageURLFromLink(link: Link) -> NSURL? {
    let URLString = link.url.absoluteString

    // Isn't Imgur url
    guard URLString.matchesWithRegex(regex) else { return nil }

    // Is already an image url
    if URLString.matchesWithRegex(extensionRegex) {
      return link.url
    }

    // gifv to gif transformation
    if link.url.pathExtension == "gifv" {
      return link.url.URLByDeletingPathExtension?.URLByAppendingPathExtension("gif")
    }

    // Media is already a gif
    if let thumbnailURL = link.media?.thumbnailURL
      where thumbnailURL.pathExtension == "gif" {
      return thumbnailURL
    }

    // Media to gif transformation (ends with CODEh.jpg should be converted to CODE.gif)
    if let thumbnailURL = link.media?.thumbnailURL
      where thumbnailURL.absoluteString.hasSuffix("h.jpg") {
      let gifLink = thumbnailURL.absoluteString
        .stringByReplacingOccurrencesOfString("h.jpg", withString: ".gif")
      return NSURL(string: gifLink)
    }

    // No extension (e.g. http://imgur.com/CODE) convert to http://i.imgur.com/CODE.jpg
    if link.url.pathExtension == "" {
      let imageLink = URLString.stringByReplacingOccurrencesOfString("imgur.com",
                                                                     withString: "i.imgur.com")
      return NSURL(string: imageLink)?.URLByAppendingPathExtension("jpg")
    }

    return nil
  }
}
