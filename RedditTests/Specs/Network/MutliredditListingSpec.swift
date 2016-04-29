//
//  MutliredditListingSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class MultiredditListSpec: QuickSpec {

  override func spec() {
    describe("A multireddit listing") {
      var listing: [Multireddit]?
      describe("can be loaded") {
        NetworkMock.provider.request(.MultiredditListing(token: "token"))
          .mapArray(Multireddit)
          .subscribeNext { networkListing in
            listing = networkListing
          }.addDisposableTo(self.rx_disposeBag)

        it("has 4 multireddits") {
          expect(listing).toEventuallyNot(beNil())
          expect(listing?.count).toEventually(equal(4))
        }
      }
    }
  }
}
