//
//  ViewController.swift
//  JBScrollingTabBarController
//
// Created by Jeff Breunig on 11/9/16.
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
import JBScrollingTabBarController

class ViewController: UIViewController {
    private var backgroundTitle: String?
    private var color: UIColor = UIColor.red
    private let label = UILabel()
    private let labelFontSize: CGFloat = 50
    
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
        label.font = UIFont.systemFont(ofSize: labelFontSize)
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
