//
//  JBScrollingTabBarController.swift
//  JBScrollingTabBarController
//
// Created by Jeff Breunig on 11/6/16.
// Copyright (c) 2016 Jeff Breunig <jkbreunig@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import JBScrollingTabBarController

extension JBScrollingTabBarController {
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Access the project's JBScrollingTabBarController instance
    
    static func getTabBarController() -> JBScrollingTabBarController? {
        return (UIApplication.shared.delegate as? AppDelegate)?.tabBarController
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Setup controllers
    
    func setupTabBarController() {
        scrollingTabBarViewControllers = getControllers()
    }
    
    private func getControllers() -> [UINavigationController] {
        var controllers = [UINavigationController]()
        let tabObjects = TabObject.getTabObjects()
        for tabObject in tabObjects {
            let navigationController = setupNavController(tabObject: tabObject)
            controllers.append(navigationController)
        }
        return controllers
    }

    private func setupNavController(tabObject: TabObject) -> UINavigationController {
        let viewController = ViewController(backgroundTitle: tabObject.viewTitle,
                                            color: tabObject.color)
        let navController = UINavigationController(rootViewController: viewController)
        let image = UIImage(named: tabObject.imageName)
        navController.tabBarItem = UITabBarItem(title: tabObject.tabTitle,
                                                image: image,
                                                selectedImage: nil)
        return navController
    }
}
