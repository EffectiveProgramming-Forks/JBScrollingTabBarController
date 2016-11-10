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
        let tabObjects: [TabObject] = [
            TabObject(color: UIColor.red, tabTitle: "One", viewTitle: "1", imageName: "One"),
            TabObject(color: UIColor.orange, tabTitle: "Two", viewTitle: "2", imageName: "Two"),
            TabObject(color: UIColor.yellow, tabTitle: "Three", viewTitle: "3", imageName: "Three"),
            TabObject(color: UIColor.green, tabTitle: "Four", viewTitle: "4", imageName: "Four"),
            TabObject(color: UIColor.blue, tabTitle: "Five", viewTitle: "5", imageName: "Five"),
            TabObject(color: UIColor.magenta, tabTitle: "Six", viewTitle: "6", imageName: "Six"),
            TabObject(color: UIColor.purple, tabTitle: "Seven", viewTitle: "7", imageName: "Seven"),
                      
        ]
        for tabObject in tabObjects {
            let navigationController = setupNavController(tabObject: tabObject)
            controllers.append(navigationController)
        }
        return controllers
    }

    private func setupNavController(tabObject: TabObject) -> UINavigationController {
        let viewController = ViewController(backgroundTitle: tabObject.viewTitle, color: tabObject.color)
        let navController = UINavigationController(rootViewController: viewController)
        let image = UIImage(named: tabObject.imageName)
        navController.tabBarItem = UITabBarItem(title: tabObject.tabTitle, image: image, selectedImage: nil)
        return navController
    }
}
