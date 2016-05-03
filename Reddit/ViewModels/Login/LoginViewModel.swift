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
import NSObject_Rx
import Result

// MARK: Properties and Initializer
class LoginViewModel: NSObject {

  // MARK: Static
  private static let clientId = "S8m1IOZ4TW9vLQ"
  private static let redirectURL = "https://github.com/ivanbruel/MVVM-Benchmark"
  private static let responseType = "code"
  private static let duration = Duration.Permanent
  private static let scopes: [Scope] = [.Subscribe, .Vote, .MySubreddits, .Submit, .Save, .Read,
                               .Report, .Identity, .Account, .Edit, .History]
  /// Show Compact page only on iPhone
  private static var authorizePath: String = {
    return Device.type() == .iPad ? "authorize" : "authorize.compact"
  }()
  private static var scopeString: String {
    return scopes.map { $0.rawValue }.joinWithSeparator(",")
  }

  // MARK: Public Properties
  var oauthURLString: String {
    return "https://www.reddit.com/api/v1/\(LoginViewModel.authorizePath)?" +
      "client_id=\(LoginViewModel.clientId)&response_type=\(LoginViewModel.responseType)" +
      "&state=\(state)&redirect_uri=\(LoginViewModel.redirectURL)" +
      "&duration=\(LoginViewModel.duration.rawValue)&scope=\(LoginViewModel.scopeString)"
  }

  var loginResult: Observable<Result<AccessToken, LoginError>> {
    return _loginResult.asObservable()
  }

  // MARK: Private Properties
  private let state = NSUUID().UUIDString
  private let _loginResult = ReplaySubject<Result<AccessToken, LoginError>>.create(bufferSize: 1)

  // MARK: Initializer
  override init() {
    super.init()
    reuseToken()
  }

  deinit {
    // Signal onCompleted when view model is released
    self._loginResult.onCompleted()
  }

}

// MARK: Token Reuse
extension LoginViewModel {

  /// Automatic login in case we already have a valid access token
  /// Or refresh the token if it has expired
  private func reuseToken() {
    if let accessToken = Globals.accessToken {
      if accessToken.expiresIn.compare(NSDate()) == .OrderedAscending {
        self._loginResult.onNext(Result(accessToken))
      } else {
        refreshToken(accessToken)
      }
    }
  }

}

// MARK: TitledViewModel
extension LoginViewModel: TitledViewModel {

  var title: Observable<String> {
    return .just(tr(.LoginTitle))
  }

}

// MARK: Validation
extension LoginViewModel {

  func isRedirectURL(URLString: String) -> Bool {
    return URLString.hasPrefix(LoginViewModel.redirectURL)
  }

  func loginWithRedirectURL(URLString: String) {
    guard URLString.hasPrefix(LoginViewModel.redirectURL) else {
      _loginResult.onNext(Result(error: .Unknown))
      return
    }

    let queryParameters = QueryReader.queryParametersFromString(URLString)

    guard let state = queryParameters["state"], code = queryParameters["code"]
      where state == self.state else {
        _loginResult.onNext(Result(error: .UserCancelled))
        return
    }
    getAccessToken(code)
  }
}

// MARK: Networking
extension LoginViewModel {

  private func getAccessToken(code: String) {
    Network.provider.request(.AccessToken(code: code, redirectURL: LoginViewModel.redirectURL,
      clientId: LoginViewModel.clientId))
      .mapObject(AccessToken)
      .bindNext { [weak self] accessToken in
        Globals.accessToken = accessToken
        self?._loginResult.onNext(Result(accessToken))
      }.addDisposableTo(rx_disposeBag)
  }

  private func refreshToken(accessToken: AccessToken) {
    Network.provider.request(.RefreshToken(refreshToken: accessToken.refreshToken,
      clientId: LoginViewModel.clientId))
      .mapObject(AccessToken)
      .bindNext { [weak self] accessToken in
        Globals.accessToken = accessToken
        self?._loginResult.onNext(Result(accessToken))
      }.addDisposableTo(rx_disposeBag)
  }
}
