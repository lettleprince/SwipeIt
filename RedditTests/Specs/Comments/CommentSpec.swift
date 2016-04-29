//
//  CommentSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 29/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//


import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx
import ObjectMapper

class CommentSpec: QuickSpec {

  override func spec() {
    describe("A comment") {
      var comment: Comment!
      describe("can be deserialized") {
        comment = JSONReader.readFromJSON("Comment")

        it("exists") {
          expect(comment).toNot(beNil())
        }

        it("is a thing") {
          expect(comment.identifier) == "d2joakv"
          expect(comment.name) == "t1_d2joakv"
          expect(comment.kind) == "t1"
        }

        it("is created") {
          expect(comment.created) == NSDate(timeIntervalSince1970: 1461783331.0)
        }

        it("is votable") {
          expect(comment.downs) == 0
          expect(comment.ups) == 352
          expect(comment.voted) == Voted.None
          expect(comment.score) == 352
        }

        it("has Comment properties") {
          expect(comment.subredditId) == "t5_2fwo"
          expect(comment.bannedBy).to(beNil())
          expect(comment.removalReason).to(beNil())
          expect(comment.linkId) == "t3_4gpqkj"
          expect(comment.userReports).to(beNil())
          expect(comment.saved) == false
          expect(comment.identifier) == "d2joakv"
          expect(comment.gilded) == 0
          expect(comment.archived) == false
          expect(comment.reportReasons).to(beNil())
          expect(comment.author) == "lykwydchykyn"
          expect(comment.parentId) == "t3_4gpqkj"
          expect(comment.approvedby).to(beNil())
          expect(comment.controversiality) == 0
          expect(comment.body) == "Instead of getting caught up in whether the interview questions were good or bad, or what this guy did wrong, it's good to consider the larger point:  how the *overall hiring process* impacts candidates psychologically.\n\nIn nearly every case he discussed, the process looks like this:\n\n- Someone (usually a recruiter) enthusiastically reaches out to the candidate asking him to apply for a job, based on his CV, github, etc.\n\n- Candidate goes through multiple rounds of interviews, sometimes taking up entire days.  Questions are asked, quite often which have seemingly nothing to do with the skills he claims to possess or the job they claim to be hiring for.\n\n- Regardless of whether he does well or poorly on the interviews, despite the fact that he's been called back for a 3rd, 4th, even 5th interview -- at some point he's simply dropped with no explanation.  Phone calls and emails are not returned.  Feedback is not provided.\n\nCan people not see how this is ultimately demoralizing and discourages people from applying for jobs?  I'll be frank and say that stories like this have discouraged me from looking for a better job.  I don't want to waste days of my time studying, traveling, talking on the phone, only to look stupid in front of my peers and be quietly rejected.\n\nI realize nobody is under obligation to coddle my insecurities, but there's a \"poisoning the well\" argument to be made here."
          expect(comment.edited) == Edited.False
          expect(comment.authorFlairClass).to(beNil())
          expect(comment.bodyHTML) == "&lt;div class=\"md\"&gt;&lt;p&gt;Instead of getting caught up in whether the interview questions were good or bad, or what this guy did wrong, it&amp;#39;s good to consider the larger point:  how the &lt;em&gt;overall hiring process&lt;/em&gt; impacts candidates psychologically.&lt;/p&gt;\n\n&lt;p&gt;In nearly every case he discussed, the process looks like this:&lt;/p&gt;\n\n&lt;ul&gt;\n&lt;li&gt;&lt;p&gt;Someone (usually a recruiter) enthusiastically reaches out to the candidate asking him to apply for a job, based on his CV, github, etc.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Candidate goes through multiple rounds of interviews, sometimes taking up entire days.  Questions are asked, quite often which have seemingly nothing to do with the skills he claims to possess or the job they claim to be hiring for.&lt;/p&gt;&lt;/li&gt;\n&lt;li&gt;&lt;p&gt;Regardless of whether he does well or poorly on the interviews, despite the fact that he&amp;#39;s been called back for a 3rd, 4th, even 5th interview -- at some point he&amp;#39;s simply dropped with no explanation.  Phone calls and emails are not returned.  Feedback is not provided.&lt;/p&gt;&lt;/li&gt;\n&lt;/ul&gt;\n\n&lt;p&gt;Can people not see how this is ultimately demoralizing and discourages people from applying for jobs?  I&amp;#39;ll be frank and say that stories like this have discouraged me from looking for a better job.  I don&amp;#39;t want to waste days of my time studying, traveling, talking on the phone, only to look stupid in front of my peers and be quietly rejected.&lt;/p&gt;\n\n&lt;p&gt;I realize nobody is under obligation to coddle my insecurities, but there&amp;#39;s a &amp;quot;poisoning the well&amp;quot; argument to be made here.&lt;/p&gt;\n&lt;/div&gt;"
          expect(comment.subreddit) == "programming"
          expect(comment.scoreHidden) == false
          expect(comment.stickied) == false
          expect(comment.authorFlairText).to(beNil())
          expect(comment.distinguished).to(beNil())
          expect(comment.modReports).to(beNil())
          expect(comment.totalReports) == 0
        }
      }
    }
  }
}
