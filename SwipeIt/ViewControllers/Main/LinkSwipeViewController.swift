//
//  SwipeViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 18/08/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift
import ZLSwipeableViewSwift

class LinkSwipeViewController: UIViewController, CloseableViewController, AlerteableViewController {

  // MARK: - IBOutlets
  @IBOutlet private weak var swipeView: ZLSwipeableView!
  @IBOutlet private weak var downvoteButton: UIButton!
  @IBOutlet private weak var upvoteButton: UIButton!
  @IBOutlet private weak var undoButton: UIButton!
  @IBOutlet private weak var shareButton: UIButton!

  // MARK: - ViewModel
  var viewModel: LinkSwipeViewModel!

  // MARK: Properties
  private var cardIndex: Int = 0
  private lazy var shareHelper: ShareHelper = ShareHelper(viewController: self)
  private lazy var alertHelper: AlertHelper = AlertHelper(viewController: self)
}

// MARK: - Lifecycle
extension LinkSwipeViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    swipeView.nextView = { [weak self] in
      self?.swipeViewNextView()
    }
  }
}

// MARK: - Setup
extension LinkSwipeViewController {

  private func setup() {
    setupCloseButton()
    setupSwipeView()
    bindViewModel()
  }

  private func setupSwipeView() {
    swipeView.animateView = ZLSwipeableView.tinderAnimateViewHandler()
    swipeView.numberOfHistoryItem = 10
    swipeView.didTap = { [weak self] (view, location) in
      guard let linkCardView = view as? LinkCardView else { return }
      self?.swipeViewTapped(linkCardView, location: location)
    }
    swipeView.didSwipe = { [weak self] (view, direction, directionVector) in
      guard let linkCardView = view as? LinkCardView else { return }
      self?.swipeViewSwiped(linkCardView, inDirection: direction, directionVector: directionVector)
    }
    swipeView.didDisappear = { [weak self] view in
      guard let linkCardView = view as? LinkCardView else { return }
      self?.swipeViewDisappeared(linkCardView)
    }
    swipeView.swiping = { [weak self] (view, location, translation) in
      guard let linkCardView = view as? LinkCardView else { return }
      self?.swipeViewSwiping(linkCardView, atLocation: location, translation: translation)
    }
    swipeView.didCancel = { [weak self] view in
      guard let linkCardView = view as? LinkCardView else { return }
      self?.swipeViewDidCancelSwiping(linkCardView)
    }

    updateUndoButton()
  }

  private func bindViewModel() {
    viewModel.title
      .bindTo(rx_title)
      .addDisposableTo(rx_disposeBag)
    viewModel.requestLinks()
    viewModel.viewModels
      .subscribeNext { [weak self] _ in
        self?.swipeView.loadViews()
      }.addDisposableTo(rx_disposeBag)
  }

  private func updateUndoButton() {
    undoButton.enabled = swipeView.history.count != 0
  }
}

// MARK: IBActions
extension LinkSwipeViewController {

  @IBAction private func upvoteClick() {
    currentCardView?.animateOverlayPercentage(1)
    swipeView.swipeTopView(inDirection: .Right)
  }

  @IBAction private func downvoteClick() {
    currentCardView?.animateOverlayPercentage(-1)
    swipeView.swipeTopView(inDirection: .Left)
  }

  @IBAction private func undoClick() {
    guard swipeView.history.count > 0 else { return }
    currentCardView?.didDisappear()
    swipeView.rewind()
    cardIndex -= 1
    updateUndoButton()
    currentViewModel?.unvote()
    currentCardView?.didAppear()
  }

  @IBAction private func shareClick() {
    guard let viewModel = currentViewModel else { return }
    shareHelper.share(viewModel.title, URL: viewModel.url, image: nil, fromView: shareButton)
  }
}

// MARK: ZLSwipeableViewDelegate
extension LinkSwipeViewController {

  private func swipeViewNextView() -> UIView? {
    guard let viewModel = self.viewModel.viewModelForIndex(cardIndex) else {
      self.viewModel.requestLinks()
      return nil
    }

    let view: LinkCardView
    switch viewModel {
    case is LinkItemImageViewModel:
      view = LinkImageCardView(frame: swipeView.bounds)
    default:
      return nil
    }
    // First card never goes through the swipeViewSwipped(...)
    if cardIndex == 0 {
      view.didAppear()
    }
    cardIndex += 1
    view.viewModel = viewModel
    view.moreOptionsClicked = swipeViewDidClickMore
    return view
  }

  private func swipeViewSwiped(view: LinkCardView, inDirection: Direction,
                               directionVector: CGVector) {
    updateUndoButton()
    currentCardView?.didAppear()

    guard let viewModel = view.viewModel else {
      return
    }
    switch inDirection {
    case Direction.Left:
      viewModel.downvote { [weak self] error in
        self?.voteCompletion(error, view: view)
      }
    case Direction.Right:
      viewModel.upvote { [weak self] error in
        self?.voteCompletion(error, view: view)
      }
    default: break
    }

    if self.viewModel.viewModelForIndex(cardIndex + 4) == nil {
      self.viewModel.requestLinks()
    }
  }

  private func swipeViewTapped(view: LinkCardView, location: CGPoint) {

  }

  private func swipeViewDisappeared(view: LinkCardView) {
    view.didDisappear()
  }

  private func swipeViewSwiping(view: LinkCardView, atLocation: CGPoint, translation: CGPoint) {
    let offset = translation.x
    let direction: CGFloat = offset >= 0 ? 1 : -1
    let min: CGFloat = 20
    let max: CGFloat = 40
    let percentage: CGFloat = ((min ... max).clamp(abs(offset)) - min)/(max - min) * direction
    view.animateOverlayPercentage(percentage)
  }

  private func swipeViewDidCancelSwiping(view: LinkCardView) {
    view.animateOverlayPercentage(0)
  }

  private func swipeViewDidClickMore(view: LinkCardView) {
    guard let viewModel = view.viewModel else { return }
    viewModel.save.take(1)
      .subscribeNext { [weak self] save in
        let options = [save, tr(.LinkReport), tr(.LinkOpenInSafari)]
        self?.alertHelper.presentActionSheet(options: options) { index in
          guard let index = index else { return }
          switch index {
          case 0:
            viewModel.toggleSave { error in
            }
          case 1:
            self?.report(viewModel)
          case 2:
            self?.openInSafari(viewModel)
          default: break
          }
        }
      }.addDisposableTo(rx_disposeBag)
  }
}

// MARK: - Helpers
extension LinkSwipeViewController {

  private func openInSafari(viewModel: LinkItemViewModel) {
    UIApplication.sharedApplication().openURL(viewModel.url)
  }

  private func report(viewModel: LinkItemViewModel) {
    let reasons: [String] = [tr(.LinkReportSpam), tr(.LinkReportVoteManipulation),
                             tr(.LinkReportPersonalInfo), tr(.LinkReportSexualizingMinors),
                             tr(.LinkReportBreakingReddit), tr(.LinkReportOther)]
    alertHelper.presentActionSheet(options: reasons) { [weak self] index in
      guard let index = index else { return }
      guard index != 5 else {
        self?.reportOtherReason(viewModel)
        return
      }
      self?.reportWithReason(reasons[index], viewModel: viewModel)
    }
  }

  private func reportOtherReason(viewModel: LinkItemViewModel) {
    let textfield = AlertTextField(text: nil, placeholder: tr(.LinkReportOtherHint))
    presentAlert(tr(.LinkReport), message: tr(.LinkReportOtherReason),
                 textField: textfield, buttonTitle: tr(.LinkReport),
                 cancelButtonTitle: tr(.AlertButtonCancel)) { [weak self] alertClicked in
                  switch alertClicked {
                  case let .ButtonWithText(reason):
                    self?.reportWithReason(reason, viewModel: viewModel)
                  default: return
                  }
    }
  }

  private func reportWithReason(reason: String?, viewModel: LinkItemViewModel) {
    guard let reason = reason else { return }
    viewModel.sendReport(reason) { error in
    }
  }

  private func voteCompletion(error: ErrorType?, view: UIView) {
    guard let _ = error where swipeView.history.last == view else {
      return
    }
    currentCardView?.didDisappear()
    swipeView.rewind()
  }

  private var currentViewModel: LinkItemViewModel? {
    return (swipeView.topView() as? LinkCardView)?.viewModel
  }

  private var currentCardView: LinkCardView? {
    return swipeView.topView() as? LinkCardView
  }
}
