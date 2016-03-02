# MVVM vs MVC Benchmark

This project is part of a benchmark between [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) and [MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) architectures in iOS app development.

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

Afterwards we will reflect upon results, and try to understand on which cases one of them trumps the other.
