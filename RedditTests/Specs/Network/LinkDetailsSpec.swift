//
//  LinkDetailsSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 28/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class LinkDetailsSpec: QuickSpec {

  override func spec() {
    describe("A link's details") {
      var link: Link?
      var commentsListing: CommentsListing?
      describe("can be loaded") {
        NetworkMock.provider.request(.LinkDetails(token: nil,
          permalink: "/r/programming/something/"))
          .mapPair(LinkListing.self, CommentsListing.self)
          .subscribeNext { (networkLinkListing, networkCommentsListing) in
            link = networkLinkListing.links?.first
            commentsListing = networkCommentsListing
          }.addDisposableTo(self.rx_disposeBag)

        it("has link properties") {
          expect(link).toEventuallyNot(beNil())
          expect(link?.domain).toEventually(equal("medium.com"))
          expect(link?.bannedBy).toEventually(beNil())
          expect(link?.embeddedMedia).toEventually(beNil())
          expect(link?.subreddit).toEventually(equal("programming"))
          expect(link?.selfTextHTML).toEventually(beNil())
          expect(link?.selfText).toEventually(beNil())
          expect(link?.voted).toEventually(equal(Voted.None))
          expect(link?.suggestedSort).toEventually(beNil())
          expect(link?.userReports).toEventually(beNil())
          expect(link?.secureMedia).toEventually(beNil())
          expect(link?.linkFlairText).toEventually(beNil())
          expect(link?.identifier).toEventually(equal("4gpqkj"))
          expect(link?.fromKind).toEventually(beNil())
          expect(link?.gilded).toEventually(equal(0))
          expect(link?.archived).toEventually(beFalse())
          expect(link?.clicked).toEventually(beFalse())
          expect(link?.reportReasons).toEventually(beNil())
          expect(link?.author).toEventually(equal("speckz"))
          expect(link?.media).toEventually(beNil())
          expect(link?.name).toEventually(equal("t3_4gpqkj"))
          expect(link?.score).toEventually(equal(273))
          expect(link?.approvedBy).toEventually(beNil())
          expect(link?.nsfw).toEventually(beFalse())
          expect(link?.hidden).toEventually(beFalse())
          expect(link?.thumbnailURL).toEventually(beNil())
          expect(link?.subredditId).toEventually(equal("t5_2fwo"))
          expect(link?.edited).toEventually(equal(Edited.False))
          expect(link?.linkFlairClass).toEventually(beNil())
          expect(link?.authorFlairClass).toEventually(beNil())
          expect(link?.downs).toEventually(equal(0))
          expect(link?.modReports).toEventually(beNil())
          expect(link?.secureEmbeddedMedia).toEventually(beNil())
          expect(link?.saved).toEventually(beFalse())
          expect(link?.removalReason).toEventually(beNil())
          expect(link?.stickied).toEventually(beFalse())
          expect(link?.from).toEventually(beNil())
          expect(link?.selfPost).toEventually(beFalse())
          expect(link?.fromId).toEventually(beNil())
          expect(link?.permalink).toEventually(equal("/r/programming/comments/4gpqkj/f_you_i_quit_hiring_is_broken/"))
          expect(link?.locked).toEventually(beFalse())
          expect(link?.hideScore).toEventually(beFalse())
          expect(link?.created).toEventually(equal(NSDate(timeIntervalSince1970: 1461780083.0)))
          expect(link?.url).toEventually(equal(NSURL(string: "https://medium.com/@evnowandforever/f-you-i-quit-hiring-is-broken-bb8f3a48d324#.a9wkit32m")))
          expect(link?.authorFlairText).toEventually(beNil())
          expect(link?.quarantine).toEventually(beFalse())
          expect(link?.title).toEventually(equal("F*** You, I Quit — Hiring Is Broken"))
          expect(link?.ups).toEventually(equal(273))
          expect(link?.upvoteRatio).toEventually(equal(0.76))
          expect(link?.totalComments).toEventually(equal(591))
          expect(link?.visited).toEventually(beFalse())
          expect(link?.totalReports).toEventually(equal(0))
          expect(link?.distinguished).toEventually(beNil())
        }

        describe("has comments listing") {

          it("has comments") {
            expect(commentsListing?.comments).toEventuallyNot(beNil())
            expect(commentsListing?.comments?.count).toEventually(equal(37))
          }

          it("has a comments tree") {
            expect(commentsListing?.comments?.first).toEventuallyNot(beNil())
            expect(commentsListing?.comments?.first?.replies).toEventuallyNot(beNil())
            expect(commentsListing?.comments?.first?.replies?.comments?.count).toEventually(equal(9))
            expect(commentsListing?.comments?.first?.replies?.moreComments?.children.count).toEventually(equal(9))
            expect(commentsListing?.comments?.first?.replies?.comments?.first?.replies?.comments?.count).toEventually(equal(7))
          }

          it("has more comments") {
            expect(commentsListing?.moreComments).toEventuallyNot(beNil())

            expect(commentsListing?.moreComments?.children).toEventually(equal(["d2kd7iu", "d2jwsy0", "d2khle5", "d2jq3db", "d2jx91y",
              "d2k0c9j", "d2kitga", "d2jyyvv", "d2kec2k", "d2kldsu",
              "d2jvtlr", "d2kmdgi", "d2kiu92", "d2jn0h3", "d2kkx7z",
              "d2ksq7k", "d2kmjzs", "d2kg8u4", "d2kd4y0", "d2jwxu3",
              "d2jocb2", "d2k8hn8", "d2kg5w5", "d2khnx2", "d2jok7r",
              "d2km2u3", "d2jv87w", "d2k3941", "d2k4y8z", "d2ksjjf",
              "d2jnyb1", "d2kg0ds", "d2js648", "d2kfed7"]))
            expect(commentsListing?.moreComments?.count).toEventually(equal(116))
            expect(commentsListing?.moreComments?.parentId).toEventually(equal("t3_4gpqkj"))
            expect(commentsListing?.moreComments?.name).toEventually(equal("t1_d2kd7iu"))
            expect(commentsListing?.moreComments?.identifier).toEventually(equal("d2kd7iu"))
          }

        }
      }
    }
  }
}
