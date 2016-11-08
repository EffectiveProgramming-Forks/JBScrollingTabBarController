//
//  FirstViewController.swift
//  JBTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit

class FirstViewController: RootViewController {
    override init() {
        super.init()
        backgroundTitle = "1"
        color = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

