//
//  JBTabBarButton.swift
//  JBTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit

class JBTabBarButton: UIButton {
    var isActive: Bool = false {
        didSet {
            updateSubviews()
        }
    }
    private var image: UIImage? {
        didSet {
            iv.image = image
        }
    }
    private var buttonSize: CGSize = CGSize(width: 25, height: 25) {
        didSet {
            updateSubviews()
        }
    }
    private var activeFont: UIFont = UIFont.TabBar.activeItem
    private var inactiveFont: UIFont! = UIFont.TabBar.inactiveItem
    private var activeColor: UIColor = UIColor.TabBar.activeItem
    private var inactiveColor: UIColor = UIColor.TabBar.inactiveItem
    let iv = UIImageView()
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Designated initializer
    
    init(image: UIImage? = nil,
         activeColor: UIColor,
         inactiveColor: UIColor,
         activeFont: UIFont,
         inactiveFont: UIFont) {
        super.init(frame: CGRect.zero)
        self.image = image
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.activeFont = activeFont
        self.inactiveFont = inactiveFont
        setupSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Setup subviews
    
    private func setupSubviews() {
        setupTitleLabel()
        setupImageView()
        updateSubviews()
        setupConstraints()
    }
    
    private func setupTitleLabel() {
        titleLabel?.font = inactiveFont
        setTitleColor(inactiveColor, for: .normal)
    }
    
    private func setupImageView() {
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iv)
    }

    //-----------------------------------------------------------------------------------------------------------
    //MARK: Update subviews
    
    func update(activeColor: UIColor?, inactiveColor: UIColor?) {
        if let activeColor = activeColor {
            self.activeColor = activeColor
        }
        if let inactiveColor = inactiveColor {
            self.inactiveColor = inactiveColor
        }
        updateSubviews()
    }
    
    func update(activeFont: UIFont?, inactiveFont: UIFont?) {
        if let activeFont = activeFont {
            self.activeFont = activeFont
        }
        if let inactiveFont = inactiveFont {
            self.inactiveFont = inactiveFont
        }
        updateSubviews()
    }
    
    private func updateSubviews() {
        if isActive {
            titleLabel?.font = activeFont
            setTitleColor(activeColor, for: .normal)
            image = image?.imageWithColor(activeColor)
        } else {
            titleLabel?.font = inactiveFont
            setTitleColor(inactiveColor, for: .normal)
            image = image?.imageWithColor(inactiveColor)
        }
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Constraints
    
    private func setupConstraints() {
        contentVerticalAlignment = UIControlContentVerticalAlignment.bottom
        let padding: CGFloat = 0
        addConstraint(NSLayoutConstraint(item: iv, attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: padding))
        addConstraint(NSLayoutConstraint(item: iv,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 5))
        addConstraint(NSLayoutConstraint(item: iv,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .height,
                                         multiplier: 1.0,
                                         constant: buttonSize.height))
    }
}


