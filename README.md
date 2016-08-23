SwipeIt
=================

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platform iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Build Status](https://travis-ci.org/ivanbruel/SwipeIt.svg?branch=master)](https://travis-ci.org/ivanbruel/SwipeIt)
[![codecov](https://codecov.io/gh/ivanbruel/SwipeIt/branch/master/graph/badge.svg)](https://codecov.io/gh/ivanbruel/SwipeIt)
[![codebeat badge](https://codebeat.co/badges/18e57729-b99d-4f4c-84a9-ef02203324c6)](https://codebeat.co/projects/github-com-ivanbruel-reddit-mvvm-benchmark)
[![GitHub issues](https://img.shields.io/github/issues/ivanbruel/SwipeIt.svg?style=flat)](https://github.com/ivanbruel/SwipeIt/issues)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/ivanbruel/SwipeIt/blob/master/LICENSE)
[![Twitter](https://img.shields.io/badge/Twitter-@ivanbruel-blue.svg?style=flat)](http://twitter.com/ivanbruel)

## Getting Started

Run the following two commands to install Xcode's command line tools and bundler, if you don't have that yet.

```bash
[sudo] gem install bundler
xcode-select --install
```

The following commands will clone the repo and install all the required dependencies.

```bash
git clone https://github.com/ivanbruel/SwipeIt.git
cd SwipeIt
bundle install
bundle exec pod install
```

Now you can open `Reddit.xcworkspace` and Run the `Reddit` target onto your simulator or iOS device.

You can also run the tests by calling:

```bash
bundle exec fastlane ios test
```

## Code style

This project will follow the [GitHub Swift Styleguide](https://github.com/github/swift-style-guide) in every way possible.

In order to enforce this, the project will also have a [Swiftlint](https://github.com/realm/SwiftLint) build phase to run the linter everytime the app is built.

Variable naming conventions will be ignored whenever a **RxSwift**-based variable is created (as the naming convention of the library is to start it with **rx_** (e.g. `rx_contentOffset`).

## Project Structure

The project follows this folder structure:

```
Reddit
├── App
│   └── AppDelegate
├── Enums
├── Extensions
├── Externals
├── Globals
├── Helpers
├── Models
├── Networking
├── Protocols
├── Resources
│   ├── LaunchScreen.storyboard
│   ├── Localizable.strings
│   └── Info.plist
├── Structs
├── ViewControllers
│   ├── Onboarding
│   │     └── Onboarding.storyboard
│   └── Main
│         └── Main.storyboard
├── ViewModels
└── Views
```

In order to enforce it to the filesystem we're using [Synx](https://github.com/venmo/synx) to keep the folder structures clean and mirroring the project structure.

## Dependencies

### Model

- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper): Simple JSON Object mapping written in Swift
- [DateTools](https://github.com/MatthewYork/DateTools): Dates and times made easy in Objective-C

### Functional Reactive Programming

- [RxSwift](https://github.com/ReactiveX/RxSwift): Reactive Programming in Swift
- [NSObject+Rx](https://github.com/RxSwiftCommunity/NSObject-Rx): Handy RxSwift extensions on NSObject, including rx_disposeBag
- [Cell+Rx](https://github.com/ivanbruel/Cell-Rx): Handy RxSwift extensions on UITableViewCell and UICollectionViewCell, including rx_reusableDisposeBag
- [RxOptional](https://github.com/RxSwiftCommunity/RxOptional): RxSwift extensions for Swift optionals and "Occupiable" types
- [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources): Table and Collection View Data Sources for RxSwift

### Networking

- [Moya](https://github.com/Moya/Moya): Network abstraction layer written in Swift
- [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper): ObjectMapper bindings for Moya and RxSwift
- [Result](https://github.com/antitypical/Result): This is a Swift µframework providing Result
- [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire): RxSwift wrapper around the elegant HTTP networking in Swift Alamofire
- [Kingfisher](https://github.com/onevcat/Kingfisher): A lightweight and pure Swift implemented library for downloading and caching image from the web.

### UI Components

None at the moment

### Utilities

- [KeychainSwift](https://github.com/marketplacer/keychain-swift): Helper functions for saving text in Keychain securely for iOS, OS X, tvOS and watchOS
- [Kanna](https://github.com/tid-kijyun/Kanna): Kanna is an XML/HTML parser for macOS / iOS / tvOS.
- [Device](https://github.com/Ekhoo/Device): Light weight tool for detecting the current device and screen size written in swift
- [AsyncSwift](https://github.com/duemunk/Async): Syntactic sugar in Swift for asynchronous dispatches in Grand Central Dispatch
- [SnapKit](https://github.com/SnapKit/SnapKit): SnapKit is a DSL to make Auto Layout easy on both iOS and OS X


### Environment

- [SwiftLint](https://github.com/realm/SwiftLint): A tool to enforce Swift style and conventions.
- [SwiftGen](https://github.com/AliSoftware/SwiftGen): A collection of Swift tools to generate Swift code (enums for your assets, storyboards, Localizable.strings, …)
- [Fabric](https://docs.fabric.io/apple/fabric/overview.html): Fabric is a mobile platform with modular kits you can mix and match to build the best apps
- [Crashlytics](https://fabric.io/kits/ios/crashlytics/install): The most powerful, yet lightest weight crash reporting solution
- [Synx](https://github.com/venmo/synx): A command-line tool that reorganizes your Xcode project folder to match your Xcode groups
- [Fastlane](https://github.com/fastlane/fastlane): The easiest way to automate building and releasing your iOS and Android apps

### Testing

- [Quick](https://github.com/Quick/Quick): The Swift (and Objective-C) testing framework.
- [Nimble](https://github.com/Quick/Nimble): A Matcher Framework for Swift and Objective-C

In order to run the tests execute:

```bash
bundle exec fastlane ios tests
```

## Continuous Integration

We are using [Travis](https://travis-ci.org/ivanbruel/MVVM-Benchmark) alongside [Fastlane](https://fastlane.tools/) to perform continuous integration both by unit testing and deploying to [Fabric](https://fabric.io) or [iTunes Connect](https://itunesconnect.apple.com) later on.

### Environment variables

To make sure Fabric and iTunes can deploy, make sure you have them set to something similar to the following environment variables. **The values are only examples!**.

**Note:** For ENV variables to work in Xcode you to set `$ defaults write com.apple.dt.Xcode UseSanitizedBuildSystemEnvironment -bool NO` and launch Xcode from the terminal. [Apple Developer Forums](https://forums.developer.apple.com/thread/8451)

#### Fabric deployment

- `SWIPEIT_SIGNING_IDENTITY_DEV`: iPhone Developer: Ivan Bruel (ID)
- `SWIPEIT_FABRIC_CLIENT_ID`: API Key from [Fabric Organization](https://www.fabric.io/settings/organizations)
- `SWIPEIT_FABRIC_SECRET`: Build Secret from [Fabric Organization](https://www.fabric.io/settings/organizations)

#### iTunes deployment

- `SWIPEIT_SIGNING_IDENTITY_PROD`: iPhone Distribution: Company Name (ID)
- `SWIPEIT_ITUNES_TEAM_ID`: Team ID from [iTunes Membership](https://developer.apple.com/account/#/membership)

### Deployment

Although all the deployment is done through Travis, you can do it manually through [Fastlane](https://github.com/ivanbruel/SwipeIt/blob/master/fastlane/README.md):

#### Deployment to Fabric

```bash
bundle exec fastlane ios fabric
```

### Deployment to iTunes Connect

```bash
bundle exec fastlane ios itunes
```

## Yet another Reddit app

This application is being developed as a side project in an effort to benchmark MVVM vs. MVC architectures, you can read more about it in [Medium](https://medium.com/faber-dev/mvvm-benchmark-in-an-mvc-world-part-1-dab952617395) and in our [MVVM vs. MVC README](https://github.com/ivanbruel/SwipeIt/blob/master/MVVM-MVC.md)

## Contributing

Should anyone want to contribute to this long-term benchmark, feel free to do pull requests, open up issues and even join me on [Twitter](https://twitter.com/ivanbruel) to discuss the architecture.
