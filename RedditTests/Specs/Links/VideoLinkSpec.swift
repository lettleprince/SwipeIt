//
//  VideoLinkSpec.swift
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

class VideoLinkSpec: QuickSpec {

  override func spec() {
    describe("A video link") {
      var link: Link!
      describe("can be deserialized") {
        link = JSONReader.readFromJSON("VideoLink")

        it("exists") {
          expect(link).toNot(beNil())
        }

        it("is a thing") {
          expect(link.identifier) == "4gb535"
          expect(link.name) == "t3_4gb535"
          expect(link.kind) == "t3"
        }

        it("is created") {
          expect(link.created) == NSDate(timeIntervalSince1970: 1461548340.0)
        }

        it("is votable") {
          expect(link.downs) == 0
          expect(link.ups) == 5140
          expect(link.voted) == Voted.None
          expect(link.score) == 5140
        }

        it("is has Link properties") {
          expect(link.author) == "Rpeezy"
          expect(link.authorFlairClass).to(beNil())
          expect(link.clicked) == false
          expect(link.domain) == "youtu.be"
          expect(link.hidden) == false
          expect(link.selfPost) == false
          expect(link.linkFlairClass).to(beNil())
          expect(link.linkFlairText).to(beNil())
          expect(link.locked) == false
          expect(link.media).toNot(beNil())
          expect(link.secureMedia).toNot(beNil())
          expect(link.mediaEmbed).toNot(beNil())
          expect(link.secureMediaEmbed).toNot(beNil())
          expect(link.previewImages).toNot(beNil())
          expect(link.totalComments).to(equal(809))
          expect(link.nsfw) == false
          expect(link.permalink) == NSURL(string: "http://reddit.com/r/videos/comments/4gb535/draymond_green_puts_reporter_in_check_after/")
          expect(link.saved) == false
          expect(link.selfText).to(beNil())
          expect(link.selfTextHTML).to(beNil())
          expect(link.subreddit) == "videos"
          expect(link.subredditId) == "t5_2qh1e"
          expect(link.thumbnailURL) == NSURL(string: "http://b.thumbs.redditmedia.com/1KJzrRRlOrXzjt5iM2z5NWjpnsWUmw4Jse5m5KsG5gw.jpg")
          expect(link.title) == "Draymond Green puts reporter in check after reporter tries to connect the Warriors winning to the Houston floods"
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
          expect(preview.identifier) == "m7-x_7nHEgt1HkglW6XrWRJEp7FsV9rqf-Ln60v9DuY"
          expect(preview.source.url) == NSURL(string: "https://i.redditmedia.com/mjUazJywhD7BnWxsK1OSCmkzYU3X4PnhSXVQjLbMb7Q.jpg?s=b9b4d0a271232d9844497a236010ede0")
          expect(preview.source.width) == 480
          expect(preview.source.height) == 360
          expect(preview.resolutions.count) == 3
          expect(preview.resolutions[0].url) == NSURL(string: "https://i.redditmedia.com/mjUazJywhD7BnWxsK1OSCmkzYU3X4PnhSXVQjLbMb7Q.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=108&amp;s=7596cb266941c45bc840cfa18d4ec0f3")
          expect(preview.resolutions[0].width) == 108
          expect(preview.resolutions[0].height) == 81
          expect(preview.resolutions[1].url) == NSURL(string: "https://i.redditmedia.com/mjUazJywhD7BnWxsK1OSCmkzYU3X4PnhSXVQjLbMb7Q.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=216&amp;s=70b6454d0f93e503426b88d9d3ffeff3")
          expect(preview.resolutions[1].width) == 216
          expect(preview.resolutions[1].height) == 162
          expect(preview.resolutions[2].url) == NSURL(string: "https://i.redditmedia.com/mjUazJywhD7BnWxsK1OSCmkzYU3X4PnhSXVQjLbMb7Q.jpg?fit=crop&amp;crop=faces%2Centropy&amp;arh=2&amp;w=320&amp;s=e7f5fbcba77dc6e9e2a109976da25a35")
          expect(preview.resolutions[2].width) == 320
          expect(preview.resolutions[2].height) == 240
          expect(preview.nsfwSource).to(beNil())
          expect(preview.nsfwResolutions).to(beNil())
        }

        it("has media") {
          let media = link.media!
          expect(media.type) == "youtube.com"
          expect(media.providerURL) == NSURL(string: "https://www.youtube.com/")
          expect(media.providerTitle) == "GREEN ON FLOODS"
          expect(media.authorName) == "Joe Farris"
          expect(media.height) == 338
          expect(media.width) == 600
          expect(media.html) == "&lt;iframe width=\"600\" height=\"338\" src=\"https://www.youtube.com/embed/VoLzNjCeNF0?feature=oembed\" frameborder=\"0\" allowfullscreen&gt;&lt;/iframe&gt;"
          expect(media.thumbnailWidth) == 480
          expect(media.thumbnailHeight) == 360
          expect(media.providerName) == "YouTube"
          expect(media.thumbnailURL) == NSURL(string: "https://i.ytimg.com/vi/VoLzNjCeNF0/hqdefault.jpg")
          expect(media.authorURL) == NSURL(string: "https://www.youtube.com/channel/UCxLnokPacZdvOW7nlFpDemA")
        }

        it("has secure media") {
          let media = link.secureMedia!
          expect(media.type) == "youtube.com"
          expect(media.providerURL) == NSURL(string: "https://www.youtube.com/")
          expect(media.providerTitle) == "GREEN ON FLOODS"
          expect(media.authorName) == "Joe Farris"
          expect(media.height) == 338
          expect(media.width) == 600
          expect(media.html) == "&lt;iframe width=\"600\" height=\"338\" src=\"https://www.youtube.com/embed/VoLzNjCeNF0?feature=oembed\" frameborder=\"0\" allowfullscreen&gt;&lt;/iframe&gt;"
          expect(media.thumbnailWidth) == 480
          expect(media.thumbnailHeight) == 360
          expect(media.providerName) == "YouTube"
          expect(media.thumbnailURL) == NSURL(string: "https://i.ytimg.com/vi/VoLzNjCeNF0/hqdefault.jpg")
          expect(media.authorURL) == NSURL(string: "https://www.youtube.com/channel/UCxLnokPacZdvOW7nlFpDemA")
        }

        it("has media embed") {
          let mediaEmbed = link.mediaEmbed!
          expect(mediaEmbed.content) == "&lt;iframe width=\"600\" height=\"338\" src=\"https://www.youtube.com/embed/VoLzNjCeNF0?feature=oembed\" frameborder=\"0\" allowfullscreen&gt;&lt;/iframe&gt;"
          expect(mediaEmbed.width) == 600
          expect(mediaEmbed.height) == 338
          expect(mediaEmbed.scrolling) == false
        }

        it("has secure media embed") {
          let mediaEmbed = link.secureMediaEmbed!
          expect(mediaEmbed.content) == "&lt;iframe width=\"600\" height=\"338\" src=\"https://www.youtube.com/embed/VoLzNjCeNF0?feature=oembed\" frameborder=\"0\" allowfullscreen&gt;&lt;/iframe&gt;"
          expect(mediaEmbed.width) == 600
          expect(mediaEmbed.height) == 338
          expect(mediaEmbed.scrolling) == false
        }
        
      }
    }
    
  }
}
