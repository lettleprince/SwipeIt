//
//  WalkthroughViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 26/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Properties and initializers
class WalkthroughViewModel {

  private let _loggedIn = PublishSubject<LoginError?>()
  private var accessToken: AccessToken?

  var loggedIn: Observable<LoginError?> {
    return _loggedIn.asObservable()
  }

  var loginViewModel: LoginViewModel {
    return LoginViewModel(loginCallback: loginWithAccessToken)
  }
}

extension WalkthroughViewModel {

  private func loginWithAccessToken(accessToken: AccessToken?, error: LoginError?) {
    if let error = error {
      _loggedIn.onNext(error)
    } else {
      self.accessToken = accessToken
      _loggedIn.onNext(nil)
    }
  }
}
