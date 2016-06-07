//
//  LinkListViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import Async

class LinkListViewController: UIViewController, TitledViewModelViewController {

  // MARK: IBOutlets
  @IBOutlet private weak var tableView: UITableView!

  // MARK: Public Properties
  var viewModel: LinkListViewModel!

}

// MARK: Lifecycle
extension LinkListViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
    setupViews()
  }
}

// MARK: Setup
extension LinkListViewController {

  private func setupViews() {
    tableView.rx_setDelegate(self)
      .addDisposableTo(rx_disposeBag)
  }

  private func bindViewModel() {
    bindTitle(viewModel)
    viewModel.requestLinks()
    viewModel.viewModels
      .bindTo(tableView.rx_itemsWithCellFactory) { (tableView, index, viewModel) in
        switch viewModel {
        case let viewModel as LinkListImageViewModel:
          let cell = tableView.dequeueReusableCell(LinkImageCell.self, index: index)
          cell.linkImageViewModel = viewModel
          viewModel.imageSize.asObservable()
            .distinctUntilChanged()
            .skip(1)
            .subscribeNext { [weak self] _ in
              self?.updateCellHeight()
          }.addDisposableTo(cell.rx_reusableDisposeBag)
          return cell
        default:
          let cell = tableView.dequeueReusableCell(LinkCell.self, index: index)
          cell.linkViewModel = viewModel
          return cell
        }
      }.addDisposableTo(rx_disposeBag)
  }

  private func updateCellHeight() {
      self.tableView.beginUpdates()
      self.tableView.endUpdates()
  }
}

// MARK: UITableViewDelegate
extension LinkListViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)
    -> CGFloat {
      guard let viewModel = viewModel.viewModelForIndex(indexPath.row) else { return 0 }
      switch viewModel {
      case let viewModel as LinkListImageViewModel:
        return LinkImageView.heightForWidth(viewModel.title, imageSize: viewModel.imageSize.value,
                                     width: tableView.bounds.width)
      default:
        return LinkView.heightForWidth(viewModel.title, width: tableView.bounds.width)
      }
  }
}
