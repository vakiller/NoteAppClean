# Table of Contents
1. [Description](#description)
2. [Getting started](#getting-started)
3. [Usage](#usage)
4. [Arhitecture](#arhitecture)
5. [Structure](#structure)
6. [Running the tests](#running-the-tests)
7. [Dependencies](#dependencies)

# NoteIn
A simple project NoteApp implement Clean Architechture!

# Description
<p>The Notein is a simple and straightforward introduction to clean architecture + mvvm-c in ios project.<br>

# Getting started
<p>
1. Xcode 14.3.1 and above<br>
2. Download the Notein project files from the repository.<br>
3. Open NoteApp.xcodeprj <br>
4. Wait project to sync with SPM.<br>
5. Run project.<br>
6. With Unit Test simply run with Command + U.<br>
You should see the list note screen, add new note by hit the add note button.<br>

# Usage
It's a simple note app, we can easily add new note, delete and edit note with no delay

# Architecture
* Notein project is implemented using the <strong>Clean Architecture + MVVM-C</strong> and using RxSwift.
* There are 3 layers in application: Domain Layer, Data Layer and Presentation Layer.
* There layers comunicated by Dependency Injection with DiContainer design pattern help layers decoupled.
* Domain layer have business (use cases), model and repository.
* Data layer have logic to connect and get data from CoreData or Api in the feature, the repository will call to the data layer.
* Presentaion implemented using the MVVM-C with model from the Domain layer.<br><br>
* Presentation have ViewControllers (view), ViewModels and using Coordinator Design Pattern to coordinate around flows.

```
RouterA().present(on: self, context: contextA(title: "NoteIn"))

```

# Structure 
* "Application": Files or resources main application such as AppDelegate, SceneDelegate.
* "Presentaion": The source code files for presentation layer.
* "DiContainer": Dependency Inject Container of application using SwiftInject. 
* "Data": The source code files for data layer.
* "Domain": The source code files for domain layer

# Running the tests
<p>The Notein project can be tested using the built-in framework XCTest simply run test like normal.
<br>With the help of clean architecture DI we can easily test all of layers in sperate way</p>

# Dependencies
[SPM](https://www.swift.org/package-manager/) is used as a dependency manager.
List of dependencies: 
* Kingfisher -> Networking library load image from internet.
* RxSwift -> Reactive Programing in.
* Snapkit -> Ui constraint library.
* Swinject -> Dependency Injection Container helper.

