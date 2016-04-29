//
//  MultiredditSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 27/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble
import Moya_ObjectMapper
import NSObject_Rx

class MultiredditSpec: QuickSpec {

  override func spec() {
    describe("A multireddit") {
      var multireddit: Multireddit!
      describe("can be deserialized") {
        multireddit = JSONReader.readFromJSON("Multireddit")

        it("exists") {
          expect(multireddit).toNot(beNil())
        }

        it("has Multireddit properties") {
          expect(multireddit.editable) == false
          expect(multireddit.displayName) == "redditpets"
          expect(multireddit.name) == "redditpets"
          expect(multireddit.descriptionHTML) == "&lt;!-- SC_OFF --&gt;&lt;div class=\"md\"&gt;&lt;p&gt;Photos of reddit pets. &amp;lt;3&lt;/p&gt;\n&lt;/div&gt;&lt;!-- SC_ON --&gt;"
          expect(multireddit.created) == NSDate(timeIntervalSince1970: 1368484554.0)
          expect(multireddit.copiedFrom).to(beNil())
          expect(multireddit.iconURL).to(beNil())
          expect(multireddit.subreddits) == ["mogmonday", "wrigleygonewild", "StellatheStar",
                                             "cannoodlebutt", "ChillyWilly", "PickleCheeseDonut",
                                             "AuronAndHisBelly", "umbros", "SosAndTheTiny",
                                             "AliceAndTheDubber", "randomrosie", "TheDailyBailey",
                                             "Toby", "cupcakecaturday", "sophiepotamus",
                                             "burritogonecuddly", "Dory", "ShedsALotAndNoTail",
                                             "kn0thingsKarma", "BomberTheBulldog", "ramsesthepup",
                                             "lunapuppy", "chickpea", "patrickthepetshark",
                                             "yukipics", "pennyandpork", "FantaFriday",
                                             "SporkMinions"]
          expect(multireddit.keyColor) == "#cee3f8"
          expect(multireddit.visibility) == MultiredditVisibility.Public
          expect(multireddit.iconName).to(beNil())
          expect(multireddit.path) == NSURL(string: "http://reddit.com/user/reddit/m/redditpets")
          expect(multireddit.descriptionMarkdown) == "Photos of reddit pets. &lt;3"
        }

        it("knows the user") {
          expect(multireddit.username) == "reddit"
        }
      }
    }
  }
}
