// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  typealias Image = UIImage
#elseif os(OSX)
  import AppKit.NSImage
  typealias Image = NSImage
#endif

enum Asset: String {
  case CommentsIcon = "CommentsIcon"
  case DownvoteIcon = "DownvoteIcon"
  case PlayIcon = "PlayIcon"
  case ShareIcon = "ShareIcon"
  case UpvoteIcon = "UpvoteIcon"
  case VotesIcon = "VotesIcon"

  var image: Image {
    return Image(asset: self)
  }
}

extension Image {
  convenience init!(asset: Asset) {
    self.init(named: asset.rawValue)
  }
}
