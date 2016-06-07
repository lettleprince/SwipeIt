// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import UIKit

extension UIImage {
  enum Asset: String {
    case CommentsIcon = "CommentsIcon"
    case DownvoteIcon = "DownvoteIcon"
    case ShareIcon = "ShareIcon"
    case UpvoteIcon = "UpvoteIcon"
    case VotesIcon = "VotesIcon"

    var image: UIImage {
      return UIImage(asset: self)
    }
  }

  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
