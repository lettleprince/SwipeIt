// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum L10n {
  /// Close
  case CloseableButtonClose
  /// Login
  case WalkthroughButtonLogin
  /// Cancel
  case AlertButtonCancel
  /// OK
  case AlertButtonOK
  /// Login
  case LoginTitle
  /// Login error
  case LoginErrorTitle
  /// Could not log in. Please try again later
  case LoginErrorUnknown
  /// Login was cancelled
  case LoginErrorUserCancelled
  /// Subscriptions
  case SubscriptionsTitle
  /// hidden
  case LinkScoreHidden
  /// GIF
  case LinkIndicatorGIF
  /// NSFW
  case LinkIndicatorNSFW
  /// Spoiler
  case LinkIndicatorSpoiler
  /// Album
  case LinkIndicatorAlbum
  /// Stickied
  case LinkContextStickied
  /// Locked
  case LinkContextLocked
  /// Read more
  case LinkContentSelfPostReadMore
  /// Upvote
  case LinkUpvote
  /// Downvote
  case LinkDownvote
  /// comment
  case LinkComment
  /// comments
  case LinkComments
  /// Report
  case LinkReport
  /// Save
  case LinkSave
  /// Unsave
  case LinkUnsave
  /// Open in Safari
  case LinkOpenInSafari
  /// Spam
  case LinkReportSpam
  /// Vote manipulation
  case LinkReportVoteManipulation
  /// Personal information
  case LinkReportPersonalInfo
  /// Sexualizing minors
  case LinkReportSexualizingMinors
  /// Breaking reddit
  case LinkReportBreakingReddit
  /// Other
  case LinkReportOther
  /// What other rule does it break?
  case LinkReportOtherReason
  /// Other reason (max 100 characters)
  case LinkReportOtherHint
  /// Hot
  case ListingTypeHot
  /// New
  case ListingTypeNew
  /// Rising
  case ListingTypeRising
  /// Controversial
  case ListingTypeControversial
  /// Top
  case ListingTypeTop
  /// Gilded
  case ListingTypeGilded
  /// Past hour
  case ListingTypeRangeHour
  /// Past 24 hours
  case ListingTypeRangeDay
  /// Past week
  case ListingTypeRangeWeek
  /// Past month
  case ListingTypeRangeMonth
  /// Past year
  case ListingTypeRangeYear
  /// All-time
  case ListingTypeRangeAllTime
  /// Retry
  case Retry
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .CloseableButtonClose:
        return L10n.tr("Closeable.Button.Close")
      case .WalkthroughButtonLogin:
        return L10n.tr("Walkthrough.Button.Login")
      case .AlertButtonCancel:
        return L10n.tr("Alert.Button.Cancel")
      case .AlertButtonOK:
        return L10n.tr("Alert.Button.OK")
      case .LoginTitle:
        return L10n.tr("Login.Title")
      case .LoginErrorTitle:
        return L10n.tr("Login.Error.Title")
      case .LoginErrorUnknown:
        return L10n.tr("Login.Error.Unknown")
      case .LoginErrorUserCancelled:
        return L10n.tr("Login.Error.UserCancelled")
      case .SubscriptionsTitle:
        return L10n.tr("Subscriptions.Title")
      case .LinkScoreHidden:
        return L10n.tr("Link.Score.Hidden")
      case .LinkIndicatorGIF:
        return L10n.tr("Link.Indicator.GIF")
      case .LinkIndicatorNSFW:
        return L10n.tr("Link.Indicator.NSFW")
      case .LinkIndicatorSpoiler:
        return L10n.tr("Link.Indicator.Spoiler")
      case .LinkIndicatorAlbum:
        return L10n.tr("Link.Indicator.Album")
      case .LinkContextStickied:
        return L10n.tr("Link.Context.Stickied")
      case .LinkContextLocked:
        return L10n.tr("Link.Context.Locked")
      case .LinkContentSelfPostReadMore:
        return L10n.tr("Link.Content.SelfPost.ReadMore")
      case .LinkUpvote:
        return L10n.tr("Link.Upvote")
      case .LinkDownvote:
        return L10n.tr("Link.Downvote")
      case .LinkComment:
        return L10n.tr("Link.Comment")
      case .LinkComments:
        return L10n.tr("Link.Comments")
      case .LinkReport:
        return L10n.tr("Link.Report")
      case .LinkSave:
        return L10n.tr("Link.Save")
      case .LinkUnsave:
        return L10n.tr("Link.Unsave")
      case .LinkOpenInSafari:
        return L10n.tr("Link.OpenInSafari")
      case .LinkReportSpam:
        return L10n.tr("Link.Report.Spam")
      case .LinkReportVoteManipulation:
        return L10n.tr("Link.Report.VoteManipulation")
      case .LinkReportPersonalInfo:
        return L10n.tr("Link.Report.PersonalInfo")
      case .LinkReportSexualizingMinors:
        return L10n.tr("Link.Report.SexualizingMinors")
      case .LinkReportBreakingReddit:
        return L10n.tr("Link.Report.BreakingReddit")
      case .LinkReportOther:
        return L10n.tr("Link.Report.Other")
      case .LinkReportOtherReason:
        return L10n.tr("Link.Report.Other.Reason")
      case .LinkReportOtherHint:
        return L10n.tr("Link.Report.Other.Hint")
      case .ListingTypeHot:
        return L10n.tr("ListingType.Hot")
      case .ListingTypeNew:
        return L10n.tr("ListingType.New")
      case .ListingTypeRising:
        return L10n.tr("ListingType.Rising")
      case .ListingTypeControversial:
        return L10n.tr("ListingType.Controversial")
      case .ListingTypeTop:
        return L10n.tr("ListingType.Top")
      case .ListingTypeGilded:
        return L10n.tr("ListingType.Gilded")
      case .ListingTypeRangeHour:
        return L10n.tr("ListingType.Range.Hour")
      case .ListingTypeRangeDay:
        return L10n.tr("ListingType.Range.Day")
      case .ListingTypeRangeWeek:
        return L10n.tr("ListingType.Range.Week")
      case .ListingTypeRangeMonth:
        return L10n.tr("ListingType.Range.Month")
      case .ListingTypeRangeYear:
        return L10n.tr("ListingType.Range.Year")
      case .ListingTypeRangeAllTime:
        return L10n.tr("ListingType.Range.AllTime")
      case .Retry:
        return L10n.tr("Retry")
    }
  }

  private static func tr(key: String, _ args: CVarArgType...) -> String {
    let format = NSLocalizedString(key, comment: "")
    return String(format: format, locale: NSLocale.currentLocale(), arguments: args)
  }
}

func tr(key: L10n) -> String {
  return key.string
}
