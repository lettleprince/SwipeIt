# MVVM+FRP vs MVC Benchmark

This project is part of a benchmark between [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)+[FRP](https://en.wikipedia.org/wiki/Functional_reactive_programming) and [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architectures in iOS app development.

This project serves as the [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) with [FRP](https://en.wikipedia.org/wiki/Functional_reactive_programming) benchmark project.

## MVVM

![MVVM](https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/MVVMPattern.png/660px-MVVMPattern.png)

**MVVM** denotes the Model-View-ViewModel arquitectural pattern, where **Model** data is encapsulated in **ViewModel** objects and the **View* does a (sometimes two-way) binding with the **ViewModel**'s **Model** representation.

## MVC

![MVC](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/MVC-Process.svg/500px-MVC-Process.svg.png)

**MVC** denotes the Model-View-Controller arquitectural pattern, where the **Controller** operates the **Model** and the **View** represents the **Model** state.

# Project

For this particular benchmark we're going to create a simple [Reddit](http://reddit.com) application using their [JSON API](https://www.reddit.com/dev/api). 

This application will try to cover most of the concerns that iOS developers actually have nowadays (e.g. asynchronous network calls, JSON parsing, image loading, collection/table views, storyboarding, user authentication, etc)

The application will be developed twice, once with an **MVC** arquitecture and again in **MVVM**.

When both application arquitectures are developed, some metrics will be measured, including:

- Runtime:
  - Binary size
  - Bootup time
  - CPU usage (and peaks)
  - Memory usage (and peaks)
  - Main thread locks
- Code:
  - Lines of code (total and average per file)
  - Number of classes
  - Number of functions and variables
  - Mutability vs Immutability
  - Testability
  - Compile time

Afterwards we will reflect upon results, and try to understand on which cases one of them trumps the other.

## Dependencies

In order to minimize development time, a few dependencies will be used:

- [Moya](https://github.com/Moya/Moya): Network abstraction layer written in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher): A lightweight and pure Swift implemented library for downloading and caching image from the web.
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper): Simple JSON Object mapping written in Swift
- [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper): ObjectMapper bindings for Moya and RxSwift
- [RxSwift](https://github.com/ReactiveX/RxSwift): Reactive Programming in Swift
- [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa/iOS): A bundle with common-usage iOS reactive extensions.
- [NSObject+Rx](https://github.com/RxSwiftCommunity/NSObject-Rx): Handy RxSwift extensions on NSObject, including rx_disposeBag.

**RxSwift**, **RxCocoa** and **NSObject+Rx** will only be used on the **MVVM+FRP* project as they are the basis for **FRP** usage in iOS (in this particular case Swift).

## Code style

This project will try to follow the [GitHub Swift Styleguide](https://github.com/github/swift-style-guide) in every way possible.

In order to enforce this, the project will also have a [Swiftlint](https://github.com/realm/SwiftLint) build phase to run the linter everytime the app is built.

Variable naming conventions will be ignored whenever a **RxSwift**-based variable is created (as the naming convention of the library is to start it with **rx_** (e.g. `rx_contentOffset`).

## Project Structure

The project will follow this folder structure whenever applicable:

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

In order to enforce it to the filesystem we'll also be using [Synx](https://github.com/venmo/synx) to keep the folder structures clean and mirroring the project structure.
