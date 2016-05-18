//
//  LinkListViewController.swift
//  Reddit
//
//  Created by Ivan Bruel on 10/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

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
    setup()
  }
}

// MARK: Setup
extension LinkListViewController {

  private func setup() {
    bindTitle(viewModel)
    viewModel.requestLinks()
  }
}
