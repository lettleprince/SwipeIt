//
//  AccessTokenSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 09/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx
import ObjectMapper

class AccessTokenSpec: QuickSpec {

  override func spec() {
    describe("An AccessToken") {
      var accessToken: AccessToken!
      describe("can be deserialized") {
        let creation = NSDate()
        accessToken = JSONReader.readFromJSON("AccessToken")

        it("exists") {
          expect(accessToken).toNot(beNil())
        }

        it("is created") {
          expect(accessToken.created).to(beCloseTo(creation, within: 1))
        }

        it("is valid") {
          expect(accessToken.tokenIsValid) == true
        }

        it("has an expiration date") {
          expect(accessToken.expirationDate).to(beCloseTo(creation.dateByAddingTimeInterval(3600), within: 1))
        }

        it("has a scope") {
          expect(accessToken.scope) == "account edit history identity mysubreddits read report save submit subscribe vote"
        }

        it("has a token") {
          expect(accessToken.token) == "10486811-D-UReiY9IUB4zIwQW9p4mBh-xrE"
        }

        it("has a refresh token") {
          expect(accessToken.refreshToken) == "10486811-9REElqPdRvbA1dfMQKQuRgLTqRE"
        }

        describe("can be refreshed") {
          let refreshTokenCreation = NSDate()
          let refreshAccessToken: AccessToken! = JSONReader.readFromJSON("RefreshToken")

          it("exists") {
            expect(refreshAccessToken).toNot(beNil())
          }

          let newAccessToken = AccessToken(accessToken: refreshAccessToken, refreshToken: accessToken.refreshToken!)

          it("was refreshed") {
            expect(newAccessToken.token) == "13154545-D-UReiY9IUB4zIwQW9p4mBh-xrE"
          }

          it("has the same refresh token") {
            expect(newAccessToken.refreshToken) == accessToken.refreshToken
          }

          it("has an expiration date") {
            expect(newAccessToken.expirationDate).to(beCloseTo(refreshTokenCreation.dateByAddingTimeInterval(3600), within: 1))
          }
        }
      }
    }
  }
}