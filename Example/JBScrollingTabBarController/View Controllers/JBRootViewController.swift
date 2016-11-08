//
//  JBRootViewController.swift
//  JBTabBarController
//
//  Created by Jeff Breunig on 11/6/16.
//  Copyright © 2016 Jeff Breunig. All rights reserved.
//

import UIKit
import JBScrollingTabBarController

class RootViewController: UIViewController {
    var backgroundTitle: String?
    var color: UIColor = UIColor.red
    private let label = UILabel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
