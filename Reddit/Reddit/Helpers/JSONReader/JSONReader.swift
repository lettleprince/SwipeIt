//
//  JSONReader.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/03/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation

class JSONReader {

  class func readJSONData(filename: String) -> NSData {
    if let path = NSBundle(forClass: self).pathForResource(filename, ofType: "json") {
      do {
        let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path),
          options: NSDataReadingOptions.DataReadingMappedIfSafe)
        return data
      } catch let error as NSError {
        print(error.localizedDescription)
      }
    } else {
      print("Could not find file: \(filename).json")
    }
    return NSData()
  }

}
