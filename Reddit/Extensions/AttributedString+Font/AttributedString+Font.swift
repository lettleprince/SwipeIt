//
//  AttributedString+Font.swift
//  Reddit
//
//  Created by Ivan Bruel on 14/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension NSAttributedString {

  func attributedStringWithFont(font: UIFont) -> NSAttributedString {
    let fontAttributedString = NSMutableAttributedString(attributedString: self)
    let fullRange = NSRange(location: 0, length: string.characters.count)
    fontAttributedString.addAttribute(NSFontAttributeName, value: font, range: fullRange)
    return fontAttributedString
  }
}
