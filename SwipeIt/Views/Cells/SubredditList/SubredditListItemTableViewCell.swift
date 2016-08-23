//
//  SubredditNameTableViewCell.swift
//  Reddit
//
//  Created by Ivan Bruel on 04/05/16.
//  Copyright © 2016 Faber Ventures. All rights reserved.
//

import UIKit

class SubredditListItemTableViewCell: UITableViewCell, ReusableCell {

  @IBOutlet private weak var nameLabel: UILabel!

  var viewModel: SubredditListItemViewModel! {
    didSet {
      nameLabel.text = viewModel.name
    }
  }
}
