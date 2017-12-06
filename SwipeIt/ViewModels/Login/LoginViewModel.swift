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
import Result

// MARK: Properties and Initializer
class LoginViewModel {

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
  private let disposeBag = DisposeBag()

  // MARK: Initializer
  init() {
    reuseToken()
  }

  deinit {
    // Signal onCompleted when view model is released
    self._loginResult.onCompleted()
  }

}

// MARK: Token Reuse
extension LoginViewModel {

  // Automatic login in case we already have a valid access token
  // Or refresh the token if it has expired
  private func reuseToken() {
    guard let accessToken = Globals.accessToken else { return }

    // Refresh token if it has a refreshToken and the access token is invalid
    if let oldRefreshToken = accessToken.refreshToken
      where !accessToken.tokenIsValid {
        refreshToken(oldRefreshToken)
        return
    }

    // Use token if token is valid
    if accessToken.tokenIsValid {
      _loginResult.onNext(Result(accessToken))
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
    // Checks if the redirect URL is the prefix of URLString, returns Unknown error in case it's not
    guard URLString.hasPrefix(LoginViewModel.redirectURL) else {
      _loginResult.onNext(Result(error: .Unknown))
      return
    }

    let queryParameters = QueryReader.queryParametersFromString(URLString)

    // Look for state and code query parameters, if they don't exist, the user Cancelled.
    guard let state = queryParameters["state"], code = queryParameters["code"]
      where state == self.state else {
        _loginResult.onNext(Result(error: .UserCancelled))
        return
    }

    // Ask for the access token with the OAuth code
    getAccessToken(code)
  }

  private func successfulLogin(accessToken: AccessToken) {
    Globals.accessToken = accessToken
    _loginResult.onNext(Result(accessToken))
  }
}

// MARK: Networking
extension LoginViewModel {

  // Retrieve the access token from the OAuth API, save it in the keychain for automatic login.
  private func getAccessToken(code: String) {
    Network.request(.AccessToken(code: code, redirectURL: LoginViewModel.redirectURL,
      clientId: LoginViewModel.clientId))
      .observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
      .mapObject(AccessToken)
      .observeOn(MainScheduler.instance)
      .bindNext { [weak self] accessToken in
        self?.successfulLogin(accessToken)
      }.addDisposableTo(disposeBag)
  }

  // The Refresh Token request does not send a new refresh_token, therefor we need to reuse the
  // refresh token from the old AccessToken.
  private func refreshToken(refreshToken: String) {

    let networkRequest = Network.request(.RefreshToken(refreshToken: refreshToken,
      clientId: LoginViewModel.clientId))
      .observeOn(SerialDispatchQueueScheduler(globalConcurrentQueueQOS: .Background))
      .mapObject(AccessToken)
      .observeOn(MainScheduler.instance)

    Observable
      .combineLatest(networkRequest, Observable.just(refreshToken)) { ($0, $1) }
      .map { (accessToken: AccessToken, refreshToken: String) in
        AccessToken(accessToken: accessToken, refreshToken: refreshToken)
      }
      .bindNext { [weak self] accessToken in
        self?.successfulLogin(accessToken)
      }.addDisposableTo(disposeBag)
  }
}
