//
//  UIView.swift
//  JBScrollingTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit 

extension UIView {
    func rotateView(_ duration: Double = 0.5, rotationAnimationKey key: String = "com.jbscrollingtabbarcontroller.rotationanimationkey") {
        if layer.animation(forKey: key) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(M_PI * 2.0)
            rotationAnimation.repeatCount = 1
            rotationAnimation.duration = duration
            layer.add(rotationAnimation, forKey: key)
        }
    }
}
