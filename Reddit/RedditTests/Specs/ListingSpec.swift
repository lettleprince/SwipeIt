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

class ListingSpec: QuickSpec {

  override func spec() {
    describe("A listing") {
      var listing: Listing!
      describe("can be loaded") {
        NetworkMock.provider.request(.Listing(token: nil, name: "all", listing: .Hot, after: nil))
          .mapObject(Listing)
          .subscribeNext { networkListing in
            listing = networkListing
          }.addDisposableTo(self.rx_disposeBag)
        expect(listing).toNot(beNil())

        it("has 25 links") {
          expect(listing.links?.count) == 25
        }
      }
    }
  }
}
