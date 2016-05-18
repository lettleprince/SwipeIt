//
//  WalkthroughViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 25/04/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

// MARK: Properties and Lifecycle
class WalkthroughViewController: UIViewController {

  var viewModel: WalkthroughViewModel! = WalkthroughViewModel()

  @IBOutlet private weak var loginButton: UIButton! {
    didSet {
      loginButton.setTitle(tr(.WalkthroughButtonLogin), forState: .Normal)
    }
  }

  @IBOutlet private weak var skipButton: UIButton! {
    didSet {
      skipButton.setTitle(tr(.WalkthroughButtonSkip), forState: .Normal)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

}

// MARK: Setup
extension WalkthroughViewController {

  private func setup() {
    viewModel.loginResult
      .bindNext { [weak self] error in
        guard let error = error else {
          self?.goToMainStoryboard()
          return
        }
        self?.showLoginError(error)
      }.addDisposableTo(self.rx_disposeBag)
  }

}

// MARK: UI
extension WalkthroughViewController: AlerteableViewController {

  private func goToMainStoryboard() {
    performSegue(StoryboardSegue.Onboarding.Main)
  }

  private func showLoginError(error: ErrorType) {
    let loginError = error as? LoginError ?? .Unknown
    presentAlert(tr(.LoginErrorTitle), message: loginError.description,
                 buttonTitle: tr(.AlertButtonOK))
  }

}

// MARK: Segue
extension WalkthroughViewController {

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let rootViewController = segue.navigationRootViewController else {
      return
    }

    switch rootViewController {
    case let loginViewController as LoginViewController:
      loginViewController.viewModel = viewModel.loginViewModel
    case let subscriptionsViewController as SubscriptionsViewController:
      subscriptionsViewController.viewModel = viewModel.subscriptionsViewModel
    default:
      return
    }
  }

}
