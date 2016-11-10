//
//  JBScrollingTabBarController.swift
//  JBScrollingTabBarController
//
//  Created by Jeff Breunig on 11/7/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
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
