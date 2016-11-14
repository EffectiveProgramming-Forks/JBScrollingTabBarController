//
//  UIView.swift
//  Pods
//
//  Created by Jeff Breunig on 11/13/16.
//
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

private typealias Layout = UIView
extension Layout {
    func centerHorizontallyInSuperview(constant: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: superview,
                                                    attribute: .centerX,
                                                    multiplier: 1.0,
                                                    constant: constant))
    }
    
    func alignWithSuperviewTop(constant: CGFloat = 0) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: superview,
                                                    attribute: .top,
                                                    multiplier: 1.0,
                                                    constant: constant))
    }
    
    func setSize(_ size: CGSize) {
        setHeight(size.height)
        setWidth(size.width)
    }
    
    func setHeight(_ height: CGFloat) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: height))
    }
    
    func setWidth(_ width: CGFloat) {
        superview?.addConstraint(NSLayoutConstraint(item: self,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: width))
    }
}
