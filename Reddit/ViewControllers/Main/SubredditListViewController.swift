//
//  SubredditListViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
import RxDataSources

// MARK: Properties
class SubredditListViewController: UIViewController, ViewModelViewController,
InsettableScrollViewViewController {

  // MARK: IBOutlets
  @IBOutlet private weak var tableView: UITableView!

  // MARK: Public Properties
  var viewModel: SubredditListViewModel!

  // MARK: InsettableScrollViewViewController Property
  var topScrollInset: CGFloat = 0
}

// MARK: Lifecycle
extension SubredditListViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

}

// MARK: Setup
extension SubredditListViewController {

  private func setup() {
    bindTableView()
    setupInsettableScrollView(tableView)
  }

  private func bindTableView() {
    let dataSource =
      RxTableViewSectionedReloadDataSource<SectionViewModel<SubredditListItemViewModel>>()

    dataSource.configureCell = { (_, tableView, indexPath, viewModel) in
      let cell = tableView.dequeueReusableCell(SubredditListItemTableViewCell.self,
                                               indexPath: indexPath)
      cell.viewModel = viewModel
      return cell
    }

    dataSource.titleForHeaderInSection = { (dataSource, index) in
      return dataSource.sectionAtIndex(index).title
    }

    dataSource.sectionIndexTitles = { dataSource in
      return dataSource.sectionModels.map { $0.title }
    }

    dataSource.sectionForSectionIndexTitle = { (_, _, index) in
      return index
    }

    viewModel
      .viewModels
      .bindTo(tableView.rx_itemsWithDataSource(dataSource))
      .addDisposableTo(rx_disposeBag)
  }

}
