//
//  UIFont+Traits.swift
//  Reddit
//
//  Created by Ivan Bruel on 15/07/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

extension UIFont {

  func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
    let descriptor = fontDescriptor()
      .fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
    return UIFont(descriptor: descriptor, size: 0)
  }

  func bold() -> UIFont {
    return withTraits(.TraitBold)
  }

  func italic() -> UIFont {
    return withTraits(.TraitItalic)
  }
}
