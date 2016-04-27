// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

enum L10n {
  /// Close
  case CloseableButtonClose
  /// Login
  case WalkthroughButtonLogin
  /// Skip
  case WalkthroughButtonSkip
  /// Cancel
  case AlertButtonCancel
  /// OK
  case AlertButtonOK
  /// Log in error
  case LoginErrorTitle
  /// Could not log in. Please try again later
  case LoginErrorUnknown
  /// Login was cancelled
  case LoginErrorUserCancelled
}

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .CloseableButtonClose:
        return L10n.tr("Closeable.Button.Close")
      case .WalkthroughButtonLogin:
        return L10n.tr("Walkthrough.Button.Login")
      case .WalkthroughButtonSkip:
        return L10n.tr("Walkthrough.Button.Skip")
      case .AlertButtonCancel:
        return L10n.tr("Alert.Button.Cancel")
      case .AlertButtonOK:
        return L10n.tr("Alert.Button.OK")
      case .LoginErrorTitle:
        return L10n.tr("Login.Error.Title")
      case .LoginErrorUnknown:
        return L10n.tr("Login.Error.Unknown")
      case .LoginErrorUserCancelled:
        return L10n.tr("Login.Error.UserCancelled")
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
