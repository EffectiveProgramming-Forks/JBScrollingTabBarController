//
//  SeventhViewController.swift
//  JBTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit

class SeventhViewController: RootViewController {
    override init() {
        super.init()
        backgroundTitle = "7"
        color = UIColor.purple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
