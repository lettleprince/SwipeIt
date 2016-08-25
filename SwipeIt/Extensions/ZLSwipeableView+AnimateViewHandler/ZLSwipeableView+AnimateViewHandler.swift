//
//  ZLSwipeableView+AnimateViewHandler.swift
//  SwipeIt
//
//  Created by Ivan Bruel on 23/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import ZLSwipeableViewSwift

extension ZLSwipeableView {

  static func tinderAnimateViewHandler() -> AnimateViewHandler {

    func animateView(view: UIView, forScale scale: CGFloat, duration: NSTimeInterval,
                     offsetFromCenter offset: CGFloat, swipeableView: ZLSwipeableView,
                                      completion: ((Bool) -> Void)? = nil) {
      let animations = {
        view.center = swipeableView.convertPoint(swipeableView.center,
                                                 fromView: swipeableView.superview)
        let translate = offset + ((swipeableView.bounds.height * (1 - scale)) / 2)
        var transform = CGAffineTransformMakeScale(scale, scale)
        transform = CGAffineTransformTranslate(transform, 0, translate)
        view.transform = transform
      }
      if duration > 0 {
        UIView.animateWithDuration(duration, delay: 0, options: .AllowUserInteraction,
                                   animations: animations, completion: completion)
      } else {
        animations()
        completion?(true)
      }
    }

    return { (view: UIView, index: Int, views: [UIView], swipeableView: ZLSwipeableView) in
      let duration = 0.4
      let offset: CGFloat = 6
      let maxIndex: CGFloat = CGFloat(min(index, 2))
      animateView(view, forScale: 1 - (maxIndex * 0.02), duration: maxIndex == 2 ? 0 : duration,
                  offsetFromCenter: offset * maxIndex, swipeableView: swipeableView)
    }
  }
}
