//
//  FifthViewController.swift
//  JBTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit

class FifthViewController: RootViewController {
    override init() {
        super.init()
        backgroundTitle = "5"
        color = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
