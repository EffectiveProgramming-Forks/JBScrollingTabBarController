//
//  JBScrollingTabBarController.swift
//  JBTeam
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 com.jeffbreunig.com. All rights reserved.
//


import UIKit

public class JBScrollingTabBarController: UITabBarController, UITabBarControllerDelegate  {
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Public API
    
    public var scrollingTabBarViewControllers: [UIViewController]? {
        didSet {
            if scrollingTabBarViewControllers?.isEmpty == false, let vc = scrollingTabBarViewControllers?[0] {
                self.viewControllers = [vc]
                setup()
            }
        }
    }
    public var maxNumberOfButtonsOnScreen = 5
    public var initialButtonIndex = 0
    public var shouldRotateButton = true
    public var rotateButtonDuration: Double = 0.5
    
    public var barTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
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
    
    public var index: Int = 0 {
        didSet {
            if let controllerCount = scrollingTabBarViewControllers?.count, index >= controllerCount {
                index = oldValue
            } else {
                didUpdateSelectedIndex()
            }
        }
    }
    
    override public var selectedViewController: UIViewController? {
        willSet {
            if let controllerCount = scrollingTabBarViewControllers?.count, controllerCount > index, let viewController = scrollingTabBarViewControllers?[index] {
                self.viewControllers = [viewController]
            }
        }
    }
    
    public private(set) var buttonSize: CGSize = CGSize(width: 25, height: 25)

    //-----------------------------------------------------------------------------------------------------------
    //MARK: Private API
    
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
    
    private let scrollView = UIScrollView()
    private var tabBarButtons: [JBTabBarButton]?
    private var didSetup = false
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Designated initializer. All arguments are optional.
    
    public init(
        barTintColor: UIColor? = nil,
        buttonActiveColor: UIColor? = nil,
        buttonInactiveColor: UIColor? = nil,
        buttonActiveFont: UIFont? = nil,
        buttonInactiveFont: UIFont? = nil) {
        
        super.init(nibName: nil, bundle: nil)
        delegate = self
        if let barTintColor = barTintColor {
            self.barTintColor = barTintColor
        }
        if let buttonActiveColor = buttonActiveColor {
            self.buttonActiveColor = buttonActiveColor
        }
        if let buttonInactiveColor = buttonInactiveColor {
            self.buttonInactiveColor = buttonInactiveColor
        }
        if let buttonActiveFont = buttonActiveFont {
            self.buttonActiveFont = buttonActiveFont
        }
        if let buttonInactiveFont = buttonInactiveFont {
            self.buttonInactiveFont = buttonInactiveFont
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        if didSetup {
            return
        }
        didSetup = true
        tabBar.barTintColor = barTintColor
        setupScrollView()
        setupTabBarButtons()
    }
    
    private func setupScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: tabBar.frame.width, height: tabBar.frame.height)
        scrollView.backgroundColor = barTintColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.isPagingEnabled = false
        tabBar.addSubview(scrollView)
    }
    
    private func setupTabBarButtons() {
        let numberOfButtons = scrollingTabBarViewControllers?.count ?? 0
        let buttonHeight = tabBar.frame.height
        let scrollViewWidth = scrollView.frame.width
        let buttonWidth: CGFloat = numberOfButtons > maxNumberOfButtonsOnScreen ? scrollViewWidth / CGFloat(maxNumberOfButtonsOnScreen) : scrollViewWidth / CGFloat(numberOfButtons)
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
                if i == initialButtonIndex {
                    initialButton = button
                }
                x += buttonWidth
            }
        }
        tabBarButtons = buttons
        scrollView.contentSize = CGSize(width: x, height: buttonHeight)
        if let initialButton = initialButton {
            didTapButton(initialButton)
        } else if let tabBarButtons = tabBarButtons  , !tabBarButtons.isEmpty {
            didTapButton(tabBarButtons[0])
        }
    }
    
    private func setupButton(xOffset: CGFloat, buttonSize: CGSize, item: UITabBarItem, tag: Int) -> JBTabBarButton {
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
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
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
        tabBarButtons?.forEach({ $0.isActive = false })
        selectedButton.isActive = true
    }
    
    private func rotate(selectedButton button: JBTabBarButton) {
        if shouldRotateButton {
            UIView.animate(withDuration: rotateButtonDuration, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
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
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView.contentOffset = CGPoint(x: centerXOffset, y: self.scrollView.contentOffset.y)
        })
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
