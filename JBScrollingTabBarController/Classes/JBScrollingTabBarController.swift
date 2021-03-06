//
//  JBScrollingTabBarController.swift
//  JBTeam
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

public class JBScrollingTabBarController: UITabBarController, UITabBarControllerDelegate  {
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Public API
    
    public var scrollingTabBarViewControllers: [UIViewController]? {
        didSet {
            if scrollingTabBarViewControllers?.isEmpty == false,
                let vc = scrollingTabBarViewControllers?[0] {
                self.viewControllers = [vc]
                setup()
            }
        }
    }
    public var shouldRotateButtons = true
    public var rotateButtonDuration: Double = Defaults.rotateButtonDuration
    
    public var barTintColor: UIColor = UIColor.TabBar.barTintColor {
        didSet {
            didUpdateBarTintColor()
        }
    }
    
    public var buttonActiveColor: UIColor = UIColor.TabBar.activeItem {
        didSet {
            updateButtonColors()
        }
    }
    
    public var buttonInactiveColor: UIColor = UIColor.TabBar.inactiveItem {
        didSet {
            updateButtonColors()
        }
    }
    
    public var buttonActiveFont: UIFont = UIFont.TabBar.activeItem {
        didSet {
            updateButtonFont()
        }
    }
    
    public var buttonInactiveFont: UIFont = UIFont.TabBar.inactiveItem {
        didSet {
            updateButtonFont()
        }
    }
    
    public var bounces: Bool = true {
        didSet {
            scrollView.bounces = bounces
        }
    }
    
    public var index: Int = 0 {
        didSet {
            if let controllerCount = scrollingTabBarViewControllers?.count,
                index >= controllerCount {
                index = oldValue
            } else {
                didUpdateSelectedIndex()
            }
        }
    }
    
    override public var selectedViewController: UIViewController? {
        willSet {
            if let controllerCount = scrollingTabBarViewControllers?.count,
                controllerCount > index,
                let viewController = scrollingTabBarViewControllers?[index] {
                self.viewControllers = [viewController]
            }
        }
    }

    //-----------------------------------------------------------------------------------------------------------
    //MARK: Private API
    
    struct Defaults {
        static let rotateButtonDuration: Double = 0.5
        static let imageSize = CGSize(width: 25, height: 25)
        static let minTabWidth: CGFloat = 50
        static let maxNumberOfButtonsOnScreen = Int(UIScreen.main.bounds.width / Defaults.minTabWidth)
    }
    
    public private(set) var imageSize: CGSize = Defaults.imageSize
    
    // Users should use scrollingTabBarViewControllers property instead of viewControllers property.
    override public var viewControllers: [UIViewController]? {
        set {
            super.viewControllers = newValue
        }
        get {
            return scrollingTabBarViewControllers
        }
    }
    
    // Users should use index property instead of selectedIndex property.
    override public var selectedIndex: Int {
        set {
            
        }
        get {
            return index
        }
    }
    private var maxNumberOfButtonsOnScreen = Defaults.maxNumberOfButtonsOnScreen
    private let scrollView = UIScrollView()
    private var tabBarButtons: [JBTabBarButton]?
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Designated initializer. All arguments are optional.
    
    public init(
        maxNumberOfButtonsOnScreen: Int = Defaults.maxNumberOfButtonsOnScreen,
        barTintColor: UIColor = UIColor.TabBar.barTintColor,
        buttonActiveColor: UIColor = UIColor.TabBar.activeItem,
        buttonInactiveColor: UIColor = UIColor.TabBar.inactiveItem,
        buttonActiveFont: UIFont = UIFont.TabBar.activeItem,
        buttonInactiveFont: UIFont = UIFont.TabBar.inactiveItem) {
        
        super.init(nibName: nil, bundle: nil)
        delegate = self
        self.maxNumberOfButtonsOnScreen = maxNumberOfButtonsOnScreen
        self.barTintColor = barTintColor
        self.buttonActiveColor = buttonActiveColor
        self.buttonInactiveColor = buttonInactiveColor
        self.buttonActiveFont = buttonActiveFont
        self.buttonInactiveFont = buttonInactiveFont
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Setup
    
    private func setup() {
        tabBar.barTintColor = barTintColor
        setupScrollView()
        setupTabBarButtons()
    }
    
    private func setupScrollView() {
        // Set scrollView frame. Cannot modify constraints for UITabBar managed by a controller.
        scrollView.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: tabBar.frame.height)
        scrollView.backgroundColor = barTintColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = bounces
        scrollView.isPagingEnabled = false
        tabBar.addSubview(scrollView)
    }
    
    private func setupTabBarButtons() {
        let numberOfButtons = scrollingTabBarViewControllers?.count ?? 0
        let buttonHeight = tabBar.frame.height
        let scrollViewWidth = scrollView.frame.width
        let buttonWidth: CGFloat
        if numberOfButtons > maxNumberOfButtonsOnScreen {
            buttonWidth = scrollViewWidth / CGFloat(maxNumberOfButtonsOnScreen)
        } else {
            buttonWidth = scrollViewWidth / CGFloat(numberOfButtons)
        }
        var initialButton: JBTabBarButton?
        var buttons = [JBTabBarButton]()
        var x: CGFloat = 0
        
        for i in 0 ..< numberOfButtons {
            if let item = scrollingTabBarViewControllers?[i].tabBarItem {
                let button = setupButton(xOffset: x,
                                         buttonSize: CGSize(width: buttonWidth, height: buttonHeight),
                                         item: item,
                                         tag: i)
                scrollView.addSubview(button)
                buttons.append(button)
                if i == index {
                    initialButton = button
                }
                x += buttonWidth
            }
        }
        tabBarButtons = buttons
        scrollView.contentSize = CGSize(width: x, height: buttonHeight)
        if let initialButton = initialButton {
            didTapButton(initialButton)
        } else if let tabBarButtons = tabBarButtons, !tabBarButtons.isEmpty {
            didTapButton(tabBarButtons[0])
        }
    }
    
    private func setupButton(xOffset: CGFloat,
                             buttonSize: CGSize,
                             item: UITabBarItem,
                             tag: Int) -> JBTabBarButton {
        let button = JBTabBarButton(image: item.selectedImage,
                                    activeColor: buttonActiveColor,
                                    inactiveColor: buttonInactiveColor,
                                    activeFont: buttonActiveFont,
                                    inactiveFont: buttonInactiveFont)
        button.frame = CGRect(x: xOffset, y: 0, width: buttonSize.width, height: buttonSize.height)
        button.backgroundColor = barTintColor
        button.setTitle(item.title, for: .normal)
        button.tag = tag
        button.addTarget(self, action: #selector(self.didTapButton(_:)), for: .touchUpInside)
        return button
    }

    //-----------------------------------------------------------------------------------------------------------
    //MARK: UITabBarControllerDelegate
    
    public func tabBarController(_ tabBarController: UITabBarController,
                                 didSelect viewController: UIViewController) {
        didUpdateSelectedIndex()
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Actions
    
    func didTapButton(_ button: JBTabBarButton) {
        index = button.tag
    }
    
    private func didUpdateSelectedIndex() {
        if let tabBarButtons = tabBarButtons, tabBarButtons.count > index {
            selectedViewController = scrollingTabBarViewControllers?[index]
            let offset = scrollView.contentOffset
            tabBar.bringSubview(toFront: scrollView)
            scrollView.contentOffset = offset
            
            // update buttons
            let selectedButton = tabBarButtons[index]
            updateActiveState(selectedButton: selectedButton)
            rotate(selectedButton: selectedButton)
            center(selectedButton: selectedButton)
        }
    }
    
    private func updateActiveState(selectedButton: JBTabBarButton) {
        tabBarButtons?.forEach { button in
            if button !== selectedButton {
                button.isActive = false
            } else {
                button.isActive = true
            }
        }
    }
    
    private func rotate(selectedButton button: JBTabBarButton) {
        if shouldRotateButtons {
            UIView.animate(withDuration: rotateButtonDuration,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                button.iv.rotateView()
                }, completion: nil)
        }
    }
    
    private func center(selectedButton: JBTabBarButton) {
        if scrollView.contentSize.width <= tabBar.bounds.width {
            return
        }
        let pointInSuperview = scrollView.convert(selectedButton.center, to: tabBar)
        let superviewCenter = scrollView.center
        var centerXOffset: CGFloat
        if selectedButton.frame.origin.x < superviewCenter.x {
            centerXOffset = 0
        } else if selectedButton.frame.origin.x > scrollView.contentSize.width - superviewCenter.x {
            centerXOffset = scrollView.contentSize.width - scrollView.frame.width
        } else {
            let diff = superviewCenter.x - pointInSuperview.x
            centerXOffset = scrollView.contentOffset.x - diff
        }
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint(x: centerXOffset, y: self.scrollView.contentOffset.y)
        }
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Update UI
    
    private func didUpdateBarTintColor() {
        tabBar.barTintColor = barTintColor
        scrollView.backgroundColor = barTintColor
        tabBarButtons?.forEach { $0.backgroundColor = barTintColor }
    }
    
    private func updateButtonColors() {
        tabBarButtons?.forEach { $0.update(activeColor: buttonActiveColor, inactiveColor: buttonInactiveColor) }
    }
    
    private func updateButtonFont() {
        tabBarButtons?.forEach { $0.update(activeFont: buttonActiveFont, inactiveFont: buttonInactiveFont) }
    }
}
