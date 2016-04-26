// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

enum L10n {
  /// Close
  case CloseableButtonClose
  /// Login
  case WalkthroughButtonLogin
  /// Skip
  case WalkthroughButtonSkip
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
