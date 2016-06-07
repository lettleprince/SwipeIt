//
//  Theming.swift
//  Reddit
//
//  Created by Ivan Bruel on 06/06/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift

class Theming {

  static let sharedInstance = Theming()

  private let theme: Variable<Theme>

  init(theme: Theme) {
    self.theme = Variable(theme)
  }

  private convenience init() {
    self.init(theme: Globals.theme ?? .Light)
  }

  func setTheme(theme: Theme) {
    self.theme.value = theme
  }
}

// MARK: Colors
extension Theming {

  var textColor: Observable<UIColor> {
    return theme.asObservable().map { $0.textColor }
  }

  var secondaryTextColor: Observable<UIColor> {
    return theme.asObservable().map { $0.secondaryTextColor }
  }

  var accentColor: Observable<UIColor> {
    return theme.asObservable().map { $0.accentColor }
  }

  var backgroundColor: Observable<UIColor> {
    return theme.asObservable().map { $0.backgroundColor }
  }
}
