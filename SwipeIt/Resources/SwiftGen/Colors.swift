// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#555555"></span>
  /// Alpha: 100% <br/> (0x555555ff)
  case DarkGray
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cbcccd"></span>
  /// Alpha: 100% <br/> (0xcbcccdff)
  case Gray
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#77cca4"></span>
  /// Alpha: 100% <br/> (0x77cca4ff)
  case Green
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f0f1f2"></span>
  /// Alpha: 100% <br/> (0xf0f1f2ff)
  case LightGray
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff8b60"></span>
  /// Alpha: 100% <br/> (0xff8b60ff)
  case Orange
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9494ff"></span>
  /// Alpha: 100% <br/> (0x9494ffff)
  case Purple
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffcc00"></span>
  /// Alpha: 100% <br/> (0xffcc00ff)
  case Yellow
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#007aff"></span>
  /// Alpha: 100% <br/> (0x007affff)
  case IOSBlue

  var rgbaValue: UInt32 {
    switch self {
    case .DarkGray: return 0x555555ff
    case .Gray: return 0xcbcccdff
    case .Green: return 0x77cca4ff
    case .LightGray: return 0xf0f1f2ff
    case .Orange: return 0xff8b60ff
    case .Purple: return 0x9494ffff
    case .Yellow: return 0xffcc00ff
    case .IOSBlue: return 0x007affff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}
// swiftlint:enable type_body_length

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
