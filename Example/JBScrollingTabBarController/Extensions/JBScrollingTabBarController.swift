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
    //MARK: Access projects JBScrollingTabBarController instance
    
    static func getTabBarController() -> JBScrollingTabBarController? {
        return (UIApplication.shared.delegate as? AppDelegate)?.tabBarController
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Setup controllers
    
    func setupTabBarController() {
        selectedIndex = 0
        scrollingTabBarViewControllers = getControllers()
    }
    
    private func getControllers() -> [UINavigationController] {
        let controllers = [
            setupNavController(rootViewController: FirstViewController(), title: "One", imageName: "One"),
            setupNavController(rootViewController: SecondViewController(), title: "Two", imageName: "Two"),
            setupNavController(rootViewController: ThirdViewController(), title: "Three", imageName: "Three"),
            setupNavController(rootViewController: FourthViewController(), title: "Four", imageName: "Four"),
            setupNavController(rootViewController: FifthViewController(), title: "Five", imageName: "Five"),
            setupNavController(rootViewController: SixthViewController(), title: "Six", imageName: "Six"),
            setupNavController(rootViewController: SeventhViewController(), title: "Seven", imageName: "Seven")
        ]
        return controllers
    }
    
    private func setupNavController(rootViewController viewController: UIViewController, title: String, imageName: String?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        let image = imageName != nil ? UIImage(named: imageName!) : nil
        navController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navController
    }
}
