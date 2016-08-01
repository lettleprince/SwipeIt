//
//  NSAttributedString+Height.swift
//  Reddit
//
//  Created by Ivan Bruel on 14/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension NSAttributedString {

  func heightWithFont(font: UIFont, forWidth width: CGFloat) -> CGFloat {
    let fontAttributedString = attributedStringWithFont(font)
    let textSize = fontAttributedString
      .boundingRectWithSize(CGSize(width: width, height: CGFloat.max),
                            options: [.UsesLineFragmentOrigin, .UsesFontLeading],
                            context: nil)
    return ceil(textSize.height + 1)
  }

  func numberOfLinesWithFont(font: UIFont, forWidth width: CGFloat) -> Int {
    let textStorage = NSTextStorage(attributedString: attributedStringWithFont(font))
    let textContainer = NSTextContainer(size: CGSize(width: width, height: CGFloat.max))
    textContainer.lineBreakMode = .ByWordWrapping
    textContainer.maximumNumberOfLines = 0
    textContainer.lineFragmentPadding = 0

    let layoutManager = NSLayoutManager()
    layoutManager.textStorage = textStorage
    layoutManager.addTextContainer(textContainer)

    var numberOfLines = 0
    var lineRange: NSRange = NSRange(location: 0, length: 0)
    var index = 0

    repeat {
      layoutManager.lineFragmentRectForGlyphAtIndex(index, effectiveRange: &lineRange)
      index = NSMaxRange(lineRange)
      numberOfLines += 1
    } while index < layoutManager.numberOfGlyphs

    return numberOfLines
  }
}
