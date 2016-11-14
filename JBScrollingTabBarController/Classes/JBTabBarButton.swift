//
//  JBTabBarButton.swift
//  JBTabBarController
//
// Created by Jeff Breunig on 11/6/16.
// Copyright (c) 2016 Jeff Breunig <jkbreunig@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
        iv.centerHorizontallyInSuperview()
        iv.alignWithSuperviewTop(constant: 5)
        iv.setSize(buttonSize)
        super.updateConstraints()
    }
}


