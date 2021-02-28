// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let backGround = ImageAsset(name: "BackGround")
  internal static let doubleHeart = ImageAsset(name: "DoubleHeart")
  internal static let logo = ImageAsset(name: "Logo")
  internal static let mobileLogo = ImageAsset(name: "MobileLogo")
  internal static let pinButtonDoctorProfile = ImageAsset(name: "PinButtonDoctorProfile")
  internal static let settingsArrow = ImageAsset(name: "SettingsArrow")
  internal static let settingsBack = ImageAsset(name: "SettingsBack")
  internal static let settingsFavorite = ImageAsset(name: "SettingsFavorite")
  internal static let settingsLogOut = ImageAsset(name: "SettingsLogOut")
  internal static let settingsLogin = ImageAsset(name: "SettingsLogin")
  internal static let settingscontact = ImageAsset(name: "Settingscontact")
  internal static let settingsshare = ImageAsset(name: "Settingsshare")
  internal static let settingssheet = ImageAsset(name: "Settingssheet")
  internal static let settingsuser = ImageAsset(name: "Settingsuser")
  internal static let success = ImageAsset(name: "Success")
  internal static let arrow = ImageAsset(name: "arrow")
  internal static let back2 = ImageAsset(name: "back2")
  internal static let backArrow = ImageAsset(name: "backArrow")
  internal static let backDoctorProfile = ImageAsset(name: "backDoctorProfile")
  internal static let calendar = ImageAsset(name: "calendar")
  internal static let cancelbutton = ImageAsset(name: "cancelbutton")
  internal static let careProfileDOctor = ImageAsset(name: "careProfileDOctor")
  internal static let clock = ImageAsset(name: "clock")
  internal static let clockDOctorProfile = ImageAsset(name: "clockDOctorProfile")
  internal static let component111 = ImageAsset(name: "component111")
  internal static let component131 = ImageAsset(name: "component131")
  internal static let component341 = ImageAsset(name: "component341")
  internal static let component67 = ImageAsset(name: "component67")
  internal static let component72 = ImageAsset(name: "component72")
  internal static let component81 = ImageAsset(name: "component81")
  internal static let component91 = ImageAsset(name: "component91")
  internal static let correct = ImageAsset(name: "correct")
  internal static let doctor = ImageAsset(name: "doctor")
  internal static let emailLogo = ImageAsset(name: "emailLogo")
  internal static let emptyStars = ImageAsset(name: "empty stars")
  internal static let failure = ImageAsset(name: "failure")
  internal static let fillStar = ImageAsset(name: "fill star")
  internal static let forwardDoctorProfile = ImageAsset(name: "forwardDoctorProfile")
  internal static let group1074 = ImageAsset(name: "group1074")
  internal static let heart = ImageAsset(name: "heart")
  internal static let heart2 = ImageAsset(name: "heart2")
  internal static let life = ImageAsset(name: "life")
  internal static let lifeDOctorProfile = ImageAsset(name: "lifeDOctorProfile")
  internal static let loginButton = ImageAsset(name: "loginButton")
  internal static let logoDoctorProfile = ImageAsset(name: "logoDoctorProfile")
  internal static let money = ImageAsset(name: "money")
  internal static let moneyDoctorProfile = ImageAsset(name: "moneyDoctorProfile")
  internal static let nameLogo = ImageAsset(name: "nameLogo")
  internal static let pin = ImageAsset(name: "pin")
  internal static let pinDoctorProfile = ImageAsset(name: "pinDoctorProfile")
  internal static let rate = ImageAsset(name: "rate")
  internal static let rectangle1798 = ImageAsset(name: "rectangle1798")
  internal static let search = ImageAsset(name: "search")
  internal static let settings = ImageAsset(name: "settings")
  internal static let settingsAboutUs = ImageAsset(name: "settingsAboutUs")
  internal static let settingsClendar = ImageAsset(name: "settingsClendar")
  internal static let signUpButton = ImageAsset(name: "signUpButton")
  internal static let `switch` = ImageAsset(name: "switch")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
