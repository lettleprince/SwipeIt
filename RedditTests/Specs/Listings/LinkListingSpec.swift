//
//  ListingSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 22/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class LinkListingSpec: QuickSpec {

  override func spec() {
    describe("A link listing") {
      var listing: LinkListing!
      describe("can be loaded") {
        NetworkMock.provider.request(.LinkListing(token: nil, subredditName: "all", listing: .Hot, after: nil))
          .mapObject(LinkListing)
          .subscribeNext { networkListing in
            listing = networkListing
          }.addDisposableTo(self.rx_disposeBag)

        it("has 25 links") {
          expect(listing).toNot(beNil())
          expect(listing.links?.count) == 25
        }
      }
    }
  }
}
