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
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum WeatherResources {
  public enum Assets {
    public static let _01 = ImageAsset(name: "01")
    public static let _02 = ImageAsset(name: "02")
    public static let _03 = ImageAsset(name: "03")
    public static let _04 = ImageAsset(name: "04")
    public static let _09 = ImageAsset(name: "09")
    public static let _10 = ImageAsset(name: "10")
    public static let _11 = ImageAsset(name: "11")
    public static let _50 = ImageAsset(name: "50")
    public enum Sf {
      public static let arrowRight = ImageAsset(name: "SF/arrow.right")
      public static let cloudSunRainFill = ImageAsset(name: "SF/cloud.sun.rain.fill")
      public static let humidityFill = ImageAsset(name: "SF/humidity.fill")
      public static let listBullet = ImageAsset(name: "SF/list.bullet")
      public static let magnifyingglass = ImageAsset(name: "SF/magnifyingglass")
      public static let mapFill = ImageAsset(name: "SF/map.fill")
      public static let sunMaxFill = ImageAsset(name: "SF/sun.max.fill")
      public static let thermometerLow = ImageAsset(name: "SF/thermometer.low")
      public static let wind = ImageAsset(name: "SF/wind")
    }

    // swiftlint:disable trailing_comma
    @available(*, deprecated, message: "All values properties are now deprecated")
    public static let allImages: [ImageAsset] = [
      _01,
      _02,
      _03,
      _04,
      _09,
      _10,
      _11,
      _50,
      Sf.arrowRight,
      Sf.cloudSunRainFill,
      Sf.humidityFill,
      Sf.listBullet,
      Sf.magnifyingglass,
      Sf.mapFill,
      Sf.sunMaxFill,
      Sf.thermometerLow,
      Sf.wind,
    ]
    // swiftlint:enable trailing_comma
  }
  public enum Colors {
    public static let background = ColorAsset(name: "background")
    public static let blue = ColorAsset(name: "blue")
    public static let blueDark = ColorAsset(name: "blueDark")
    public static let gray = ColorAsset(name: "gray")
    public static let orange = ColorAsset(name: "orange")
    public static let section = ColorAsset(name: "section")

    // swiftlint:disable trailing_comma
    @available(*, deprecated, message: "All values properties are now deprecated")
    public static let allColors: [ColorAsset] = [
      background,
      blue,
      blueDark,
      gray,
      orange,
      section,
    ]
    // swiftlint:enable trailing_comma
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = Color(asset: self)

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
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

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
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
