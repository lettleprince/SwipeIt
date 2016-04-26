//
//  LoginViewModel.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import Foundation
import Device
import RxSwift
import Moya_ObjectMapper
import ObjectMapper

// MARK: Properties and Initializer
class LoginViewModel {

  typealias LoginCallback = (AccessToken?, LoginError?) -> Void

  // MARK: Link Generation
  private static var clientId = "S8m1IOZ4TW9vLQ"
  private static var redirectURL = "https://github.com/ivanbruel/MVVM-Benchmark"
  private static var responseType = "token"
  private static var scopes = ["subscribe", "vote", "mysubreddits", "submit", "save", "read",
                               "report", "identity", "account", "edit", "history"]
  private static var authorizePath: String = {
    return Device.type() == .iPad ? "authorize" : "authorize.compact"
  }()
  private static var scopeString: String {
    return scopes.joinWithSeparator(",")
  }

  private var state = NSUUID().UUIDString
  var oauthURLString: String {
    return "https://www.reddit.com/api/v1/\(LoginViewModel.authorizePath)?" +
      "client_id=\(LoginViewModel.clientId)&response_type=\(LoginViewModel.responseType)" +
      "&state=\(state)&redirect_uri=\(LoginViewModel.redirectURL)" +
      "&scope=\(LoginViewModel.scopeString)"
  }

  // MARK: Properties
  private let loginCallback: LoginCallback

  init(loginCallback: LoginCallback) {
    self.loginCallback = loginCallback
  }
}

// MARK: Validation
extension LoginViewModel {

  func isRedirectURL(URLString: String) -> Bool {
    return URLString.hasPrefix(LoginViewModel.redirectURL)
  }

  func loginWithRedirectURL(URLString: String) {
    guard let urlComponents = NSURLComponents(string: URLString),
      fragment = urlComponents.fragment
      where URLString.hasPrefix(LoginViewModel.redirectURL) else {
        return loginCallback(nil, .Unknown)
    }

    let json = QueryReader.queryParametersFromString(fragment)

    guard let accessToken = Mapper<AccessToken>().map(json) where accessToken.state == state else {
      return loginCallback(nil, .UserCancelled)
    }
    return loginCallback(accessToken, nil)
  }
}
