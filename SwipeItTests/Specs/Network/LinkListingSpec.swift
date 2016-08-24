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
      var listing: LinkListing?
      describe("can be loaded") {
        NetworkMock.request(.LinkListing(token: "token", path: "/r/all",
          listingPath: ListingType.Hot.path, listingTypeRange: "hot", after: nil))
          .mapObject(LinkListing)
          .subscribeNext { networkListing in
            listing = networkListing
          }.addDisposableTo(self.rx_disposeBag)

        it("has 25 links") {
          expect(listing).toEventuallyNot(beNil())
          expect(listing?.links?.count).toEventually(equal(25))
        }
      }
    }
  }
}
