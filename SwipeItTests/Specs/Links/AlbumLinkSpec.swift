//
//  AlbumLinkSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 11/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx
import ObjectMapper

class AlbumLinkSpec: QuickSpec {

  override func spec() {
    describe("An album link") {
      var link: Link!
      describe("can be deserialized") {
        link = JSONReader.readFromJSON("AlbumLink")

        it("exists") {
          expect(link).toNot(beNil())
        }

        it("is a thing") {
          expect(link.identifier) == "4sc6x1"
          expect(link.name) == "t3_4sc6x1"
          expect(link.kind) == "t3"
        }

        it("is created") {
          expect(link.created) == NSDate(timeIntervalSince1970: 1468258852.0)
        }

        it("is votable") {
          expect(link.downs) == 0
          expect(link.ups) == 4834
          expect(link.vote) == Vote.None
          expect(link.score) == 4834
        }

        it("has Link properties") {
          expect(link.author) == "codeman869"
          expect(link.authorFlairClass).to(beNil())
          expect(link.clicked) == false
          expect(link.domain) == "imgur.com"
          expect(link.hidden) == false
          expect(link.selfPost) == false
          expect(link.linkFlairClass).to(beNil())
          expect(link.linkFlairText).to(beNil())
          expect(link.locked) == false
          expect(link.media).toNot(beNil())
          expect(link.secureMedia).toNot(beNil())
          expect(link.embeddedMedia).toNot(beNil())
          expect(link.secureEmbeddedMedia).toNot(beNil())
          expect(link.previewImages).toNot(beNil())
          expect(link.totalComments) == 838
          expect(link.nsfw) == false
          expect(link.permalink) == "/r/DIY/comments/4sc6x1/epoxy_coated_my_garage_floor/"
          expect(link.saved) == false
          expect(link.selfText).to(beNil())
          expect(link.selfTextHTML).to(beNil())
          expect(link.subreddit) == "DIY"
          expect(link.subredditId) == "t5_2qh7d"
          expect(link.thumbnailURL) == NSURL(string: "http://b.thumbs.redditmedia.com/-kkyOZVAFsJOIHvl9tsOL8OfXxmmxa4HhISw6_h0mkc.jpg")
          expect(link.title) == "Epoxy Coated my garage floor"
          expect(link.edited) == Edited.False
          expect(link.distinguished).to(beNil())
          expect(link.stickied) == false
          expect(link.gilded) == 1
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

        it("has the album link type") {
          expect(link.type) == LinkType.Album
          expect(link.imageURL) == NSURL(string: "https://i.redditmedia.com/HEdWun2jEkdgqAvGb68rMH_kLp_X0x9fBNc6OqDNj4M.jpg?s=c12bec494c5118bf471541587d686b0c")
          //expect(link.imageSize) == CGSize(width: 460, height: 460)
        }
      }
    }
  }
}
