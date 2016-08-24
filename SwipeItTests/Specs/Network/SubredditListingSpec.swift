//
//  SubredditListSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class SubredditListSpec: QuickSpec {

  override func spec() {
    describe("A subreddit listing") {
      var listing: SubredditListing?
      describe("can be loaded") {
        NetworkMock.request(.SubredditListing(token: "token", after: nil))
          .mapObject(SubredditListing)
          .subscribeNext { networkListing in
            listing = networkListing
          }.addDisposableTo(self.rx_disposeBag)

        it("has 25 subreddits") {
          expect(listing).toEventuallyNot(beNil())
          expect(listing?.subreddits?.count).toEventually(equal(25))
        }
      }
    }
  }
}
