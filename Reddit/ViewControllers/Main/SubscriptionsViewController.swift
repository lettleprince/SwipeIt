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

// MARK: Properties
class SubscriptionsViewController: UIViewController, HideableHairlineViewController,
TitledViewModelViewController {

  // MARK: IBOutlets
  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  @IBOutlet private weak var toolbar: UIToolbar!

  // MARK: Private Properties
  private var pageViewController: PageViewController! {
    didSet {
      pageViewController.pageViewControllerDelegate = self
    }
  }

  // MARK: Public Properties
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

    // Remove the line in the UINavigationBar so the UIToolbar and UINavigation bar appear as merged
    hideHairline()
  }

  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)

    // show the line in the UINavigationBar whenever the view controller pushes content
    showHairline()
  }

}

// MARK: Setup
extension SubscriptionsViewController {

  private func setup() {
    bindTitle()
    bindPageViewController()
    bindSegmentedControl()
  }

  // Binding any change of the PageViewController's selectedIndex to the segmentedControl
  private func bindPageViewController() {
    pageViewController.rx_selectedIndex
      .asObservable()
      .bindTo(segmentedControl.rx_value)
      .addDisposableTo(rx_disposeBag)
  }

  // Binding any change of the segmentedControl's value to the PageViewController's selectedIndex
  private func bindSegmentedControl() {
    segmentedControl.rx_value
      .asObservable()
      .bindTo(pageViewController.rx_selectedIndex)
      .addDisposableTo(rx_disposeBag)
  }

}

// MARK: PageViewControllerDelegate
extension SubscriptionsViewController: PageViewControllerDelegate {

  func pageViewController(pageViewController: PageViewController, didTransitionToIndex: Int) { }

  func pageViewController(pageViewController: PageViewController,
                          prepareForSegue segue: UIStoryboardSegue, sender: AnyObject?) {

    guard let segueEnum = StoryboardSegue.Main(optionalRawValue: segue.identifier) else { return }

    // Set the subredditListViewController viewModel and topScrollInset (to offset the toolbar)
    if let subredditListViewController
      = segue.destinationViewController as? SubredditListViewController
      where segueEnum == .PageSubredditList {
      subredditListViewController.viewModel = viewModel.subredditListViewModel
      subredditListViewController.topScrollInset = toolbar.frame.maxY
    }

    // Set the multiredditListViewController viewModel and topScrollInset (to offset the toolbar)
    if let multiredditListViewController
      = segue.destinationViewController as? MultiredditListViewController
      where segueEnum == .PageMultiredditList {
      multiredditListViewController.viewModel = viewModel.multiredditListViewModel
      multiredditListViewController.topScrollInset = toolbar.frame.maxY
    }
  }

}

// MARK: UIToolbarDelegate
extension SubscriptionsViewController: UIToolbarDelegate {

  // This will attach the UIToolbar to the navigation bar
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
