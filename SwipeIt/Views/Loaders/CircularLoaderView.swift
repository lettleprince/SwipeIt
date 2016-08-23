//
//  CircularLoaderView.swift
//  Reddit
//
//  Created by Ivan Bruel on 08/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

@IBDesignable class CircularLoaderView: UIView {

  // MARK: - IBInspectable Properties
  @IBInspectable var progress: Float {
    get {
      return max(min(Float(progressLayer.progress ?? 0), 1), 0)
    }
    set {
      progressLayer.animated = false
      progressLayer.progress = CGFloat(progress)
    }
  }

  @IBInspectable var emptyLineColor: UIColor = UIColor.lightGrayColor() {
    didSet {
      layer.borderColor = emptyLineColor.CGColor
    }
  }

  @IBInspectable var progressLineColor: UIColor {
    get {
      return progressLayer.progressLineColor
    }
    set {
      progressLayer.progressLineColor = newValue
    }
  }

  @IBInspectable var emptyLineWidth: CGFloat = 1 {
    didSet {
      layer.borderWidth = emptyLineWidth
      progressLayer.emptyLineWidth = emptyLineWidth
    }
  }

  @IBInspectable var progressLineWidth: CGFloat {
    get {
      return progressLayer.progressLineWidth
    }
    set {
      progressLayer.progressLineWidth = newValue
    }
  }

  // MARK: - Initializers
  init() {
    super.init(frame: CGRect.zero)
    commonInit()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  // MARK: - Private Functions
  private func commonInit() {
    opaque = false
    backgroundColor = .clearColor()
    progressLayer.contentsScale = UIScreen.mainScreen().scale
    progressLayer.progressLineWidth = 4
  }

  private var progressLayer: CircularLoaderLayer {
    return layer as! CircularLoaderLayer // swiftlint:disable:this force_cast
  }

  func setProgress(progress: Float, animated: Bool) {
    progressLayer.animated = animated
    progressLayer.removeAllAnimations()
    progressLayer.progress = CGFloat(progress)
    if progress == 0 {
      layer.setNeedsDisplay()
    }
  }
}

// MARK: - Layer Management
extension CircularLoaderView {

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.height / 2
  }

  override class func layerClass() -> AnyClass {
    return CircularLoaderLayer.self
  }
}

// MARK: - CircularLoaderLayer
private class CircularLoaderLayer: CALayer {

  @NSManaged var progress: CGFloat
  @NSManaged var animated: Bool
  @NSManaged var emptyLineWidth: CGFloat
  @NSManaged var progressLineWidth: CGFloat
  @NSManaged var progressLineColor: UIColor

  override func drawInContext(context: CGContext) {
    super.drawInContext(context)

    UIGraphicsPushContext(context)

    let size = CGContextGetClipBoundingBox(context).integral.size
    drawProgressBar(size, context: context)

    UIGraphicsPopContext()
  }


  private func drawProgressBar(size: CGSize, context: CGContext) {
    guard progressLineWidth > 0  else { return }

    let arc = CGPathCreateMutable()
    let initialValue = -CGFloat(M_PI_2)
    let angle = ((CGFloat(M_PI) * 2) * progress) + initialValue

    CGPathAddArc(arc, nil, size.width / 2, size.height / 2,
                 (min(size.width, size.height) / 2) - emptyLineWidth - (progressLineWidth / 2),
                 angle, initialValue, true)
    let strokedArc = CGPathCreateCopyByStrokingPath(arc, nil, progressLineWidth, .Butt, .Miter, 10)
    CGContextAddPath(context, strokedArc)
    CGContextSetStrokeColorWithColor(context, progressLineColor.CGColor)
    CGContextSetFillColorWithColor(context, progressLineColor.CGColor)
    CGContextDrawPath(context, .FillStroke)
  }

  override class func needsDisplayForKey(key: String) -> Bool {
    guard key == "progress" else {
      return super.needsDisplayForKey(key)
    }
    return true
  }

  override func actionForKey(event: String) -> CAAction? {
    guard let presentationLayer = presentationLayer() where event == "progress" && animated else {
      return super.actionForKey(event)
    }
    let animation = CABasicAnimation(keyPath: "progress")
    animation.fromValue = presentationLayer.valueForKey("progress")
    return animation
  }

}
