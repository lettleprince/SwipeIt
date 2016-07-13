Reddit
=================

[![Swift 2.2](https://img.shields.io/badge/Swift-2.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Platform iOS](https://img.shields.io/badge/Platforms-iOS-lightgray.svg?style=flat)](https://developer.apple.com/swift/)
[![Build Status](https://travis-ci.org/ivanbruel/Reddit-MVVM-Benchmark.svg?branch=master)](https://travis-ci.org/ivanbruel/Reddit-MVVM-Benchmark)
[![codecov](https://codecov.io/gh/ivanbruel/Reddit-MVVM-Benchmark/branch/master/graph/badge.svg)](https://codecov.io/gh/ivanbruel/Reddit-MVVM-Benchmark)
[![codebeat badge](https://codebeat.co/badges/18e57729-b99d-4f4c-84a9-ef02203324c6)](https://codebeat.co/projects/github-com-ivanbruel-reddit-mvvm-benchmark)
[![GitHub issues](https://img.shields.io/github/issues/ivanbruel/Reddit-MVVM-Benchmark.svg)](https://github.com/ivanbruel/Reddit-MVVM-Benchmark/issues)
[![License Apache](https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat)](https://github.com/ivanbruel/Reddit-MVVM-Benchmark/blob/master/LICENSE)
[![Twitter](https://img.shields.io/badge/Twitter-@ivanbruel-blue.svg?style=flat)](http://twitter.com/ivanbruel)

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

## Continuous Integration

We are using [Travis](https://travis-ci.org/ivanbruel/MVVM-Benchmark) alongside [Fastlane](https://fastlane.tools/) to perform continuous integration both by unit testing and deploying to [Fabric](https://fabric.io) or [iTunes Connect](https://itunesconnect.apple.com) later on.

## Contributing

Should anyone want to contribute to this long-term benchmark, feel free to do pull requests, open up issues and even join me on [Twitter](https://twitter.com/ivanbruel) to discuss the architecture.
