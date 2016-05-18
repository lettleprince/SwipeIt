//
//  OpenGraphSpec.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Quick
import Nimble

class OpenGraphSpec: QuickSpec {

  override func spec() {
    describe("An OpenGraph Object") {
      let openGraph: OpenGraph = OpenGraph(html: FileReader.readFileString("OpenGraph", fileExtension: "html"))!
      describe("can be parsed") {

        it("exists") {
          expect(openGraph).toNot(beNil())
        }

        it("has a title") {
          expect(openGraph.title) == "Jury is picked for $9 billion Oracle v. Google showdown"
        }

        it("has a description") {
          expect(openGraph.description) == "Only one juror worked with computers, and he was Oracle's first strike."
        }

        it("has an image") {
          expect(openGraph.imageURL) == NSURL(string: "http://cdn.arstechnica.net/wp-content/uploads/2012/05/jury_box1-640x427.jpg")
        }
      }
    }
  }
}
