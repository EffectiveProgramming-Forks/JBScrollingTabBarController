//
//  TabObject.swift
//  JBScrollingTabBarController
//
//  Created by Jeff Breunig on 11/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

struct TabObject {
    var color: UIColor
    var tabTitle: String
    var viewTitle: String
    var imageName: String
    
    init(color: UIColor,
         tabTitle: String,
         viewTitle: String,
         imageName: String) {
        self.color = color
        self.tabTitle = tabTitle
        self.viewTitle = viewTitle
        self.imageName = imageName
    }
    
    static func getTabObjects() -> [TabObject] {
        return [
            TabObject(color: UIColor.red,
                      tabTitle: "One",
                      viewTitle: "1",
                      imageName: "One"),
            TabObject(color: UIColor.orange,
                      tabTitle: "Two",
                      viewTitle: "2",
                      imageName: "Two"),
            TabObject(color: UIColor.yellow,
                      tabTitle: "Three",
                      viewTitle: "3",
                      imageName: "Three"),
            TabObject(color: UIColor.green,
                      tabTitle: "Four",
                      viewTitle: "4",
                      imageName: "Four"),
            TabObject(color: UIColor.blue,
                      tabTitle: "Five",
                      viewTitle: "5",
                      imageName: "Five"),
            TabObject(color: UIColor.magenta,
                      tabTitle: "Six",
                      viewTitle: "6",
                      imageName: "Six"),
            TabObject(color: UIColor.purple,
                      tabTitle: "Seven",
                      viewTitle: "7",
                      imageName: "Seven")
        ]
    }
}
