//
//  OpenGraphAppLinksSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble

class OpenGraphAppLinksSpec: QuickSpec {

  override func spec() {
    describe("An OpenGraph Object") {
      let openGraph: OpenGraph = OpenGraph(html: FileReader.readFileString("OpenGraphAppLinks", fileExtension: "html"))!
      
      describe("can be parsed") {

        it("exists") {
          expect(openGraph).toNot(beNil())
        }

        it("has a title") {
          expect(openGraph.title) == "OutRun"
        }

        it("has a description") {
          expect(openGraph.description) == "OutRun, an album by Kavinsky on Spotify"
        }

        it("has an image") {
          expect(openGraph.imageURL) == NSURL(string: "http://o.scdn.co/cover/cc475da5faf02f1a9f0cdc60550bbcb88e91f256")
        }

        describe("has an appLink") {
          expect(openGraph.appLink).toNot(beNil())

          it("has an url") {
            expect(openGraph.appLink?.url) == NSURL(string: "spotify://album/3bRM4GQgoFjBRRzhp87Ugb")
          }

          it("has an appName") {
            expect(openGraph.appLink?.appName) == "Spotify"
          }

          it("has an appStoreId") {
            expect(openGraph.appLink?.appStoreId) == "324684580"
          }
        }
      }
    }
  }
}
