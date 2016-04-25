//
//  LinkSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx
import ObjectMapper

class LinkSpec: QuickSpec {

  override func spec() {
    describe("A link") {
      var link: Link!
      describe("can be deserialized") {
        link = JSONReader.readFromJSON("ImageLink")

        it("exists") {
          expect(link).toNot(beNil())
        }

        it("is a thing") {
          expect(link.identifier).to(equal("4g95yg"))
          expect(link.name).to(equal("t3_4g95yg"))
          expect(link.kind).to(equal("t3"))
        }

        it("is created") {
          expect(link.created).to(equal(NSDate(timeIntervalSince1970: 1461520568.0)))
        }

        it("is votable") {
          expect(link.downs).to(equal(0))
          expect(link.ups).to(equal(3070))
          expect(link.likes).to(equal(Likes.NoVote))
          expect(link.score).to(equal(3070))
        }

        it("is has Link properties") {
          expect(link.author).to(equal("Tentaye"))
          expect(link.authorFlairCssClass).to(beNil())
          expect(link.clicked).to(beFalse())
          expect(link.domain).to(equal("imgur.com"))
          expect(link.hidden).to(beFalse())
          expect(link.isSelf).to(beFalse())
          expect(link.linkFlairCssClass).to(equal("s-limited"))
          expect(link.linkFlairText).to(equal("Limited"))
          expect(link.locked).to(beFalse())
          expect(link.media).to(beNil())
          expect(link.secureMedia).to(beNil())
          expect(link.mediaEmbed).to(beNil())
          expect(link.secureMediaEmbed).to(beNil())
          expect(link.preview).toNot(beNil())
          expect(link.numComments).to(equal(192))
          expect(link.nsfw).to(beFalse())
          expect(link.permalink).to(equal("/r/gameofthrones/comments/4g95yg/s6waiting_in_anticipation/"))
          expect(link.saved).to(beFalse())
          expect(link.selfText).to(beNil())
          expect(link.selfTextHtml).to(beNil())
          expect(link.subreddit).to(equal("gameofthrones"))
          expect(link.subredditId).to(equal("t5_2rjz2"))
          expect(link.thumbnail?.absoluteString).to(equal("http://b.thumbs.redditmedia.com/-A_gDsO9AdMCb5KbkS6WK4FPCfS653tB4CCh50KzcvY.jpg"))
          expect(link.title).to(equal("[S6]Waiting in anticipation"))
          expect(link.edited).to(equal(Edited.False))
          expect(link.distinguished).to(beNil())
          expect(link.stickied).to(beFalse())
          expect(link.gilded).to(equal(0))
          expect(link.visited).to(beFalse())
        }

        it("has misc properties") {
          expect(link.approvedBy).to(beNil())
          expect(link.bannedBy).to(beNil())
          expect(link.suggestedSort).to(beNil())
          expect(link.userReports).to(beNil())
          expect(link.fromKind).to(beNil())
          expect(link.archived).to(beFalse())
          expect(link.reportReasons).to(beNil())
          expect(link.from).to(beNil())
          expect(link.fromId).to(beNil())
          expect(link.quarantine).to(beFalse())
          expect(link.modReports).to(beNil())
          expect(link.numReports).to(beNil())
        }

        it("has image one preview") {
          let preview = link.preview!.first!
          expect(preview.identifier).to(equal("XgCZOc3am9i6KasrtmhDhHY05HDgrgrSo-Y6isJlIoc"))
          expect(preview.source.url.absoluteString).to(equal("https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?s=1d4f660b91f6ce1ae83fda3af83c8243"))
          expect(preview.source.width).to(equal(460))
          expect(preview.source.height).to(equal(460))
          expect(preview.resolutions.count).to(equal(3))
          expect(preview.resolutions[0].url.absoluteString).to(equal("https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=108&amp;s=7ca207022959f57303bbb48b2589ef03"))
          expect(preview.resolutions[0].width).to(equal(108))
          expect(preview.resolutions[0].height).to(equal(108))
          expect(preview.resolutions[1].url.absoluteString).to(equal("https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=216&amp;s=4ca86ed3896238a2a5cd2a7cb472d824"))
          expect(preview.resolutions[1].width).to(equal(216))
          expect(preview.resolutions[1].height).to(equal(216))
          expect(preview.resolutions[2].url.absoluteString).to(equal("https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=320&amp;s=c9a1a0c63e9ffe5a954a3ccc72d87c0f"))
          expect(preview.resolutions[2].width).to(equal(320))
          expect(preview.resolutions[2].height).to(equal(320))
          expect(preview.nsfwSource).to(beNil())
          expect(preview.nsfwResolutions).to(beNil())
        }

      }
    }

  }
}
