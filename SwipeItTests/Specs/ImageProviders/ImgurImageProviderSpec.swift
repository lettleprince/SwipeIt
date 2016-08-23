//
//  ImgurImageProvider.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx
import ObjectMapper

class ImgurImageProviderSpec: QuickSpec {

  override func spec() {
    describe("An ImgurImageProvider") {

      let linkListing: LinkListing = JSONReader.readFromJSON("Pics")!
      describe("can provide static images") {
        let imageURLs = linkListing.links.flatMap { ImgurImageProvider.imageURLFromLink($0) }
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/CzbwOcd.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/H3f3N6yh.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/TaO4Q13.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/uM6zV5L.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/DUt9uJO.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/yVN1xsG.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/MlnzxLB.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/73JlmEv.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/RwyPQJx.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/CzbwOcd.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/CzbwOcd.jpg")))
        expect(imageURLs).to(contain(NSURL(string: "http://i.imgur.com/CzbwOcd.jpg")))
      }
    }
  }
}
