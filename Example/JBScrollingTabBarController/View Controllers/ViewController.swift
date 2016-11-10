//
//  ViewController.swift
//  JBScrollingTabBarController
//
//  Created by Jeff Breunig on 11/9/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import JBScrollingTabBarController

class ViewController: UIViewController {
    private var backgroundTitle: String?
    private var color: UIColor = UIColor.red
    private let label = UILabel()
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Designated initializer
    
    init(backgroundTitle: String, color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.backgroundTitle = backgroundTitle
        self.color = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        addLabel()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        JBScrollingTabBarController.getTabBarController()?.buttonActiveColor = color
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Subviews
    
    private func addLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = backgroundTitle
        view.addSubview(label)
    }
    
    //-----------------------------------------------------------------------------------------------------------
    //MARK: Constraints
    
    private func setupConstraints() {
        label.fillSuperview()
        updateViewConstraints()
    }
}
