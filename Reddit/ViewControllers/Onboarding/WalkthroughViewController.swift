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
      .bindNext { error in
        guard let error = error else {
          self.goToMainStoryboard()
          return
        }
        self.showLoginError(error)
    }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: UI
extension WalkthroughViewController: AlerteableViewController {

  private func goToMainStoryboard() {
    print("go to main storyboard")
  }

  private func showLoginError(error: LoginError) {
    print("Error \(error)")
    presentAlert(tr(.LoginErrorTitle), message: error.description, buttonTitle: tr(.AlertButtonOK))
      .bindNext { (buttonClicked) in
      print(buttonClicked)
    }.addDisposableTo(rx_disposeBag)
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
