//
//  SubredditSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class SubredditSpec: QuickSpec {

  override func spec() {
    describe("A subreddit") {
      var subreddit: Subreddit!
      describe("can be deserialized") {
        subreddit = JSONReader.readFromJSON("Subreddit")

        it("exists") {
          expect(subreddit).toNot(beNil())
        }

        it("is a thing") {
          expect(subreddit.identifier) == "2fwo"
          expect(subreddit.name) == "t5_2fwo"
          expect(subreddit.kind) == "t5"
        }

        it("is created") {
          expect(subreddit.created) == NSDate(timeIntervalSince1970: 1141150769.0)
        }

        it("has Subreddit properties") {
          expect(subreddit.bannerImage).to(beNil())
          expect(subreddit.submitTextHTML).to(beNil())
          expect(subreddit.wikiEnabled) == true
          expect(subreddit.submitText).to(beNil())
          expect(subreddit.displayName) == "programming"
          expect(subreddit.headerImage) == NSURL(string: "http://b.thumbs.redditmedia.com/2rTE46grzsr-Ll3Q.png")
          expect(subreddit.descriptionHTML) == "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;&lt;a href=\"/r/programming\"&gt;/r/programming&lt;/a&gt; is a reddit for discussion and news about &lt;a href=\"http://en.wikipedia.org/wiki/Computer_programming\"&gt;computer programming&lt;/a&gt;&lt;/p&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;&lt;strong&gt;Guidelines&lt;/strong&gt;&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Please try to keep submissions on topic and of high quality.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Just because it has a computer in it doesn&amp;#39;t make it programming.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Memes and image macros are not acceptable forms of content.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;If there is no code in your link, it probably doesn&amp;#39;t belong here.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;App demos should include code and/or architecture discussion.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Please follow proper &lt;a href=\"https://www.reddit.com/help/reddiquette\"&gt;reddiquette&lt;/a&gt;.&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;&lt;strong&gt;Info&lt;/strong&gt;&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Do you have a question? Check out &lt;a href=\"/r/learnprogramming\"&gt;/r/learnprogramming&lt;/a&gt;, &lt;a href=\"/r/cscareerquestions\"&gt;/r/cscareerquestions&lt;/a&gt;, or &lt;a href=\"https://www.stackoverflow.com\"&gt;stackoverflow&lt;/a&gt;.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Do you have something funny to share with fellow programmers? Please take it to &lt;a href=\"/r/ProgrammerHumor/\"&gt;/r/ProgrammerHumor/&lt;/a&gt;.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;For posting job listings, please visit &lt;a href=\"/r/forhire\"&gt;/r/forhire&lt;/a&gt; or &lt;a href=\"/r/jobbit\"&gt;/r/jobbit&lt;/a&gt;.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Check out our &lt;a href=\"http://www.reddit.com/r/programming/wiki/faq\"&gt;faq&lt;/a&gt;.  It could use some updating.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;If you&amp;#39;re an all-star hacker (or even just beginning), why not join the discussion at &lt;a href=\"https://www.reddit.com/r/redditdev\"&gt;/r/redditdev&lt;/a&gt; and steal our &lt;a href=\"https://github.com/reddit/reddit/wiki\"&gt;reddit code&lt;/a&gt;!&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;hr/&gt;\n\n&lt;p&gt;&lt;strong&gt;Related reddits&lt;/strong&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/technology\"&gt;/r/technology&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/learnprogramming\"&gt;/r/learnprogramming&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/askprogramming\"&gt;/r/askprogramming&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/coding\"&gt;/r/coding&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/compsci\"&gt;/r/compsci&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/dailyprogrammer\"&gt;/r/dailyprogrammer&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/netsec\"&gt;/r/netsec&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/webdev\"&gt;/r/webdev&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/web_design\"&gt;/r/web_design&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/gamedev\"&gt;/r/gamedev&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/cscareerquestions\"&gt;/r/cscareerquestions&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/reverseengineering\"&gt;/r/reverseengineering&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/startups\"&gt;/r/startups&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;a href=\"/r/techsupport\"&gt;/r/techsupport&lt;/a&gt;&lt;/p&gt;\n\n&lt;p&gt;&lt;strong&gt;&lt;a href=\"https://www.reddit.com/r/programming/wiki/faq#wiki_what_language_reddits_are_there.3F\"&gt;Specific languages&lt;/a&gt;&lt;/strong&gt;&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"
          expect(subreddit.title) == "programming"
          expect(subreddit.collapseDeletedComments) == false
          expect(subreddit.publicDescription) == "Computer Programming"
          expect(subreddit.nsfw) == false
          expect(subreddit.publicDescriptionHTML) == "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;Computer Programming&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"
          expect(subreddit.iconWidth).to(beNil())
          expect(subreddit.iconHeight).to(beNil())
          expect(subreddit.suggestedCommentSort).to(beNil())
          expect(subreddit.iconImage).to(beNil())
          expect(subreddit.headerTitle).to(beNil())
          expect(subreddit.description) == "/r/programming is a reddit for discussion and news about [computer programming](http://en.wikipedia.org/wiki/Computer_programming)\n\n****\n**Guidelines**\n\n* Please try to keep submissions on topic and of high quality.\n\n* Just because it has a computer in it doesn't make it programming.\n\n* Memes and image macros are not acceptable forms of content.\n\n* If there is no code in your link, it probably doesn't belong here.\n\n* App demos should include code and/or architecture discussion.\n\n* Please follow proper [reddiquette](https://www.reddit.com/help/reddiquette).\n\n****\n**Info**\n\n* Do you have a question? Check out /r/learnprogramming, /r/cscareerquestions, or [stackoverflow](https://www.stackoverflow.com).\n\n* Do you have something funny to share with fellow programmers? Please take it to /r/ProgrammerHumor/.\n\n* For posting job listings, please visit /r/forhire or /r/jobbit.\n\n* Check out our [faq](http://www.reddit.com/r/programming/wiki/faq).  It could use some updating.\n\n* If you're an all-star hacker (or even just beginning), why not join the discussion at [/r/redditdev](https://www.reddit.com/r/redditdev) and steal our [reddit code](https://github.com/reddit/reddit/wiki)!\n\n****\n**Related reddits**\n\n/r/technology\n\n/r/learnprogramming\n\n/r/askprogramming\n\n/r/coding\n\n/r/compsci\n\n/r/dailyprogrammer\n\n/r/netsec\n\n/r/webdev\n\n/r/web_design\n\n/r/gamedev\n\n/r/cscareerquestions\n\n/r/reverseengineering\n\n/r/startups\n\n/r/techsupport\n\n**[Specific languages](https://www.reddit.com/r/programming/wiki/faq#wiki_what_language_reddits_are_there.3F)**"
          expect(subreddit.submitLinkLabel).to(beNil())
          expect(subreddit.accountsActive).to(beNil())
          expect(subreddit.publicTraffic) == false
          expect(subreddit.headerWidth) == 120
          expect(subreddit.headerHeight) == 40
          expect(subreddit.totalSubscribers) == 658044
          expect(subreddit.submitTextLabel).to(beNil())
          expect(subreddit.language) == "en"
          expect(subreddit.keyColor).to(beNil())
          expect(subreddit.url) == NSURL(string: "http://reddit.com/r/programming/")
          expect(subreddit.path) == "/r/programming/"
          expect(subreddit.quarantine) == false
          expect(subreddit.hideAds) == false
          expect(subreddit.bannerWidth).to(beNil())
          expect(subreddit.bannerHeight).to(beNil())
          expect(subreddit.commentScoreHideMins) == 0
          expect(subreddit.subredditType) == SubredditType.Public
          expect(subreddit.submissionType) == SubmissionType.Link
        }

        it("has user properties") {
          expect(subreddit.userIsSubscriber) == true
          expect(subreddit.userIsModerator) == false
          expect(subreddit.userSubredditThemeEnabled) == true
          expect(subreddit.userIsBanned) == false
          expect(subreddit.userIsMuted) == false
          expect(subreddit.userIsContributor) == false
        }
      }
    }
  }
}
