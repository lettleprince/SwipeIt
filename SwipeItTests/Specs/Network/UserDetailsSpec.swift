//
//  UserDetailsSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 29/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class UserDetailsSpec: QuickSpec {

  override func spec() {
    describe("A user") {
      var user: User?
      describe("can be loaded") {
        NetworkMock.provider.request(.UserDetails(token: nil, username: "jakewharton"))
          .mapObject(User)
          .subscribeNext { networkUser in
            user = networkUser
          }.addDisposableTo(self.rx_disposeBag)

        it("has user details") {
          expect(user).toEventuallyNot(beNil())
          expect(user?.name).toEventually(equal("JakeWharton"))
          expect(user?.isFriend).toEventually(beFalse())
          expect(user?.created).toEventually(equal(NSDate(timeIntervalSince1970: 1280868066)))
          expect(user?.linkKarma).toEventually(equal(626))
          expect(user?.commentKarma).toEventually(equal(5463))
          expect(user?.isGold).toEventually(beFalse())
          expect(user?.isMod).toEventually(beFalse())
          expect(user?.hasVerifiedEmailAddress).toEventually(beFalse())
          expect(user?.identifier).toEventually(equal("488da"))
        }
      }
    }
  }
}
