
# JBScrollingTabBarController

[![CI Status](http://img.shields.io/travis/Jeff Breunig/JBScrollingTabBarController.svg?style=flat)](https://travis-ci.org/Jeff Breunig/JBScrollingTabBarController)
[![Version](https://img.shields.io/cocoapods/v/JBScrollingTabBarController.svg?style=flat)](http://cocoapods.org/pods/JBScrollingTabBarController)
[![License](https://img.shields.io/cocoapods/l/JBScrollingTabBarController.svg?style=flat)](http://cocoapods.org/pods/JBScrollingTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/JBScrollingTabBarController.svg?style=flat)](http://cocoapods.org/pods/JBScrollingTabBarController)

![](http://gph.is/2fzvycm?tc=1)
![](http://i.giphy.com/1100I6bT8lHx9m.gif)

**JBScrollingTabBarController** is a scrollable and customizable UITabBarController subclass that allows the user to display more than 5 TabBarItems without showing a More navigation interface.

## Requirements

- iOS 9.0+
- Swift 3.0
- Xcode 8.0

## Installation

**JBScrollingTabBarController** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JBScrollingTabBarController"
```

## Example

To run the example project, clone the repo, and run the project from the Example directory.

```swift
## Usage

import JBScrollingTabBarController

// Instantiate JBScrollingTabBarController

let tabBarController = JBScrollingTabBarController(barTintColor: UIColor.white,
                                                       buttonActiveColor: UIColor.blue,
                                                       buttonInactiveColor: UIColor.lightGray,
                                                       buttonActiveFont: UIFont.boldSystemFont(ofSize: 12),
                                                       buttonInactiveFont: UIFont.systemFont(ofSize: 12))

// Assign controllers to JBScrollingTabBarController instance

tabBarController.scrollingTabBarViewControllers = [
            setupNavController(rootViewController: FirstViewController(), title: "One", imageName: "One"),
            setupNavController(rootViewController: SecondViewController(), title: "Two", imageName: "Two"),
            setupNavController(rootViewController: ThirdViewController(), title: "Three", imageName: "Three"),
            setupNavController(rootViewController: FourthViewController(), title: "Four", imageName: "Four"),
            setupNavController(rootViewController: FifthViewController(), title: "Five", imageName: "Five"),
            setupNavController(rootViewController: SixthViewController(), title: "Six", imageName: "Six"),
            setupNavController(rootViewController: SeventhViewController(), title: "Seven", imageName: "Seven")
]
    
private func setupNavController(rootViewController viewController: UIViewController, 
title: String, 
imageName: String?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        let image = imageName != nil ? UIImage(named: imageName!) : nil
        navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navController
}  

// Set initial selected button index

tabBarController.index = 0 

// Assign JBScrollingTabBarController instance as the window's rootViewController in application:didFinishLaunchingWithOptions

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        tabBarController.setupTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }

### JBScrollingTabBarController public API                                               

var scrollingTabBarViewControllers: [UIViewController]?
var maxNumberOfButtonsOnScreen: Int
var initialButtonIndex: Int
var shouldRotateButtons = true
var rotateButtonDuration: Double
var barTintColor: UIColor   
var buttonActiveColor: UIColor  
var buttonInactiveColor: UIColor
var buttonActiveFont: UIFont   
var buttonInactiveFont: UIFont 
var index: Int
var selectedViewController: UIViewController?    
```

## Author

Jeff Breunig, jkbreunig@gmail.com

## License

JBScrollingTabBarController is available under the MIT license. See the LICENSE file for more info.
