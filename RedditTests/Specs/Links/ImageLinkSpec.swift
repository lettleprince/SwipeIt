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

class ImageLinkSpec: QuickSpec {

  override func spec() {
    describe("An image link") {
      var link: Link!
      describe("can be deserialized") {
        link = JSONReader.readFromJSON("ImageLink")

        it("exists") {
          expect(link).toNot(beNil())
        }

        it("is a thing") {
          expect(link.identifier) == "4g95yg"
          expect(link.name) == "t3_4g95yg"
          expect(link.kind) == "t3"
        }

        it("is created") {
          expect(link.created) == NSDate(timeIntervalSince1970: 1461520568.0)
        }

        it("is votable") {
          expect(link.downs) == 0
          expect(link.ups) == 3070
          expect(link.vote) == Vote.None
          expect(link.score) == 3070
        }

        it("has Link properties") {
          expect(link.author) == "Tentaye"
          expect(link.authorFlairClass).to(beNil())
          expect(link.clicked) == false
          expect(link.domain) == "imgur.com"
          expect(link.hidden) == false
          expect(link.selfPost) == false
          expect(link.linkFlairClass) == "s-limited"
          expect(link.linkFlairText) == "Limited"
          expect(link.locked) == false
          expect(link.media).to(beNil())
          expect(link.secureMedia).to(beNil())
          expect(link.embeddedMedia).to(beNil())
          expect(link.secureEmbeddedMedia).to(beNil())
          expect(link.previewImages).toNot(beNil())
          expect(link.totalComments) == 192
          expect(link.nsfw) == false
          expect(link.permalink) == "/r/gameofthrones/comments/4g95yg/s6waiting_in_anticipation/"
          expect(link.saved) == false
          expect(link.selfText).to(beNil())
          expect(link.selfTextHTML).to(beNil())
          expect(link.subreddit) == "gameofthrones"
          expect(link.subredditId) == "t5_2rjz2"
          expect(link.thumbnailURL) == NSURL(string: "http://b.thumbs.redditmedia.com/-A_gDsO9AdMCb5KbkS6WK4FPCfS653tB4CCh50KzcvY.jpg")
          expect(link.title) == "[S6]Waiting in anticipation"
          expect(link.edited) == Edited.False
          expect(link.distinguished).to(beNil())
          expect(link.stickied) == false
          expect(link.gilded) == 0
          expect(link.visited) == false
        }

        it("has misc properties") {
          expect(link.approvedBy).to(beNil())
          expect(link.bannedBy).to(beNil())
          expect(link.suggestedSort).to(beNil())
          expect(link.userReports).to(beNil())
          expect(link.fromKind).to(beNil())
          expect(link.archived) == false
          expect(link.reportReasons).to(beNil())
          expect(link.from).to(beNil())
          expect(link.fromId).to(beNil())
          expect(link.quarantine) == false
          expect(link.modReports).to(beNil())
          expect(link.totalReports) == 0
        }

        it("has one image preview") {
          expect(link.previewImages?.count) == 1

          let preview = link.previewImages!.first!
          expect(preview.identifier) == "XgCZOc3am9i6KasrtmhDhHY05HDgrgrSo-Y6isJlIoc"
          expect(preview.source.url) == NSURL(string: "https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?s=1d4f660b91f6ce1ae83fda3af83c8243")
          expect(preview.source.width) == 460
          expect(preview.source.height) == 460
          expect(preview.resolutions.count) == 3
          expect(preview.resolutions[0].url) == NSURL(string: "https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=108&amp;s=7ca207022959f57303bbb48b2589ef03")
          expect(preview.resolutions[0].width) == 108
          expect(preview.resolutions[0].height) == 108
          expect(preview.resolutions[1].url) == NSURL(string: "https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=216&amp;s=4ca86ed3896238a2a5cd2a7cb472d824")
          expect(preview.resolutions[1].width) == 216
          expect(preview.resolutions[1].height) == 216
          expect(preview.resolutions[2].url) == NSURL(string: "https://i.redditmedia.com/wHLsAOLJS0LI0_VpZEoNo-hXMDYAr-YIhoz5FV3a-bA.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=320&amp;s=c9a1a0c63e9ffe5a954a3ccc72d87c0f")
          expect(preview.resolutions[2].width) == 320
          expect(preview.resolutions[2].height) == 320
          expect(preview.nsfwSource).to(beNil())
          expect(preview.nsfwResolutions).to(beNil())
        }

      }
    }
  }
}
