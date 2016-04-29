//
//  SelfLinkSpec.swift
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

class SelfLinkSpec: QuickSpec {

  override func spec() {
    describe("A self link") {
      var link: Link!
      describe("can be deserialized") {
        link = JSONReader.readFromJSON("SelfLink")

        it("exists") {
          expect(link).toNot(beNil())
        }

        it("is a thing") {
          expect(link.identifier) == "4eujyq"
          expect(link.name) == "t3_4eujyq"
          expect(link.kind) == "t3"
        }

        it("is created") {
          expect(link.created) == NSDate(timeIntervalSince1970: 1460685487.0)
        }

        it("is votable") {
          expect(link.downs) == 0
          expect(link.ups) == 1523
          expect(link.voted) == Voted.Upvoted
          expect(link.score) == 1523
        }

        it("has Link properties") {
          expect(link.author) == "UnholyDemigod"
          expect(link.authorFlairClass).to(beNil())
          expect(link.clicked) == true
          expect(link.domain) == "self.AskReddit"
          expect(link.hidden) == false
          expect(link.selfPost) == true
          expect(link.linkFlairClass) == "mod-post"
          expect(link.linkFlairText) == "Modpost"
          expect(link.locked) == false
          expect(link.media).to(beNil())
          expect(link.secureMedia).to(beNil())
          expect(link.embeddedMedia).to(beNil())
          expect(link.secureEmbeddedMedia).to(beNil())
          expect(link.previewImages).to(beNil())
          expect(link.totalComments) == 439
          expect(link.nsfw) == false
          expect(link.permalink) == "/r/AskReddit/comments/4eujyq/raskreddits_originality_contest_round_2/"
          expect(link.saved) == true
          expect(link.selfTextHTML) == "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;Hey readers! You may remember that some time ago we had a &lt;a href=\"https://www.reddit.com/r/AskReddit/comments/2z2lu1/announcing_a_small_contest_to_promote_originality/\"&gt;little contest&lt;/a&gt; for the most original question. Well it was pretty popular at the time, so we&amp;#39;re going to follow our own trend of originality and hold the exact same contest again. The rules for the contest are as follows:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;the question deemed most original &lt;em&gt;and&lt;/em&gt; discussion inspiring as voted &lt;em&gt;by the mods&lt;/em&gt; will receive reddit gold and a night with the supermodel of your choice (provided you seek her/him out of your own accord and they agree to your advances)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;&amp;#39;Sexiest sex you ever sexed&amp;#39; or any other NSFW threads do not qualify. We want originality, not something you can jerk off to. &lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;threads do not have to be marked as serious to be considered. &lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;post must be within all the rules of the sub (duh)&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;most importantly: this is not forced entry. If you do not wish to wrack your brain thinking of something new, feel free to ask any of the other generic questions that pop up every day. &lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;p&gt;Apart from that, all you have to do is think of a question to post. We will do all the work of saving links and voting on them and whatnot, so you can browse and read the same way you always do. The contest will last for a fortnight from today (this thread will be stickied the whole time), after which we go to our secret hideout on Skull Island and decide which we think is the winner (or winners, if we can&amp;#39;t choose). &lt;/p&gt;\n\n&lt;p&gt;EDIT: disclaimer that is apparently required - do not post your questions in here. Post them as you normally would. &lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"
          expect(link.selfText) == "Hey readers! You may remember that some time ago we had a [little contest](https://www.reddit.com/r/AskReddit/comments/2z2lu1/announcing_a_small_contest_to_promote_originality/) for the most original question. Well it was pretty popular at the time, so we're going to follow our own trend of originality and hold the exact same contest again. The rules for the contest are as follows:\n\n* the question deemed most original *and* discussion inspiring as voted *by the mods* will receive reddit gold and a night with the supermodel of your choice (provided you seek her/him out of your own accord and they agree to your advances)\n\n* 'Sexiest sex you ever sexed' or any other NSFW threads do not qualify. We want originality, not something you can jerk off to. \n\n* threads do not have to be marked as serious to be considered. \n\n* post must be within all the rules of the sub (duh)\n\n* most importantly: this is not forced entry. If you do not wish to wrack your brain thinking of something new, feel free to ask any of the other generic questions that pop up every day. \n\nApart from that, all you have to do is think of a question to post. We will do all the work of saving links and voting on them and whatnot, so you can browse and read the same way you always do. The contest will last for a fortnight from today (this thread will be stickied the whole time), after which we go to our secret hideout on Skull Island and decide which we think is the winner (or winners, if we can't choose). \n\nEDIT: disclaimer that is apparently required - do not post your questions in here. Post them as you normally would. \n\n"
          expect(link.subreddit) == "AskReddit"
          expect(link.subredditId) == "t5_2qh1i"
          expect(link.thumbnailURL).to(beNil())
          expect(link.title) == "/r/askreddit's originality contest, round 2"
          expect(link.edited) == Edited.True(editedAt: NSDate(timeIntervalSince1970: 1460685963.0))
          expect(link.distinguished) == Distinguished.Moderator
          expect(link.stickied) == true
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
      }
    }
  }
}
