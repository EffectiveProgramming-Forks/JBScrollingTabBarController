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
}
