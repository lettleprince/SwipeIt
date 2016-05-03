//
//  SubscriptionsViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 02/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: Properties and Initializers
class SubscriptionsViewController: UIViewController, HideableHairlineViewController,
TitledViewModelViewController {

  // MARK: IBOutles
  @IBOutlet private weak var toolbar: UIToolbar!
  @IBOutlet private weak var segmentedControl: UISegmentedControl! {
    didSet {
      segmentedControl.rx_value
        .asDriver()
        .driveNext { index in }
        .addDisposableTo(rx_disposeBag)
    }
  }

  private var pageViewController: PageViewController!

  var viewModel: SubscriptionsViewModel!

}

// MARK: Lifecycle
extension SubscriptionsViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    hideHairline()
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    showHairline()
  }

}

// MARK: Setup
extension SubscriptionsViewController {

  private func setup() {
    bindTitle()
  }

}

// MARK: UIToolbarDelegate
extension SubscriptionsViewController: UIToolbarDelegate {

  func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
    return .TopAttached
  }
}

// MARK: Segues
extension SubscriptionsViewController {

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let segueEnum = StoryboardSegue.Main(optionalRawValue: segue.identifier) else { return }

    if let pageViewController = segue.destinationViewController as? PageViewController
      where segueEnum == .EmbedPageViewController {
      self.pageViewController = pageViewController
    }
  }

}
