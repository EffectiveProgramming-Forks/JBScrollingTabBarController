//
//  UIView.swift
//  JBScrollingTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit 

private typealias Layout = UIView
extension Layout {
    func fillSuperview() {
        let views = ["view": self]
        superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
        superview?.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                 options: NSLayoutFormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
    }
}
