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

  private let viewModel = WalkthroughViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewModel()
  }

}

// MARK: Setup
extension WalkthroughViewController {

  private func setupViewModel() {
    viewModel.loggedIn
      .subscribe { event in
      switch event {
      case .Next:
        self.goToMainStoryboard()
      case .Error(let error):
        guard let loginError = error as? LoginError else {
          return
        }
        self.showLoginError(loginError)
      default:
        break
      }
    }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: UI
extension WalkthroughViewController {

  private func goToMainStoryboard() {
    print("go to main storyboard")
  }

  private func showLoginError(error: LoginError) {
    print("Error \(error)")
  }

}

// MARK: Segue
extension WalkthroughViewController {

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let loginViewController = segue.navigationRootViewController as? LoginViewController
      else {
        return
    }

    loginViewController.viewModel = viewModel.loginViewModel
  }

}
