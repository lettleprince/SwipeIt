//
//  ImageAttachment.swift
//  Reddit
//
//  Created by Ivan Bruel on 22/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class ImageAttachment: NSTextAttachment {
  var verticalOffset: CGFloat = 0.0

  // To vertically center the image, pass in the font descender as the vertical offset.
  // We cannot get this info from the text container since it is sometimes nil when
  // `attachmentBoundsForTextContainer` is called.
  convenience init(_ image: UIImage, verticalOffset: CGFloat = 0.0) {
    self.init()
    self.image = image
    self.verticalOffset = verticalOffset
  }

  override func attachmentBoundsForTextContainer(
    textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect,
    glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
    guard let image = image else { return .zero }

    let height = lineFrag.size.height
    let imageSize = image.size

    return CGRect(x: 0, y: round(verticalOffset - (imageSize.height - height)/2),
                  width: imageSize.width, height: imageSize.height)
  }
}
