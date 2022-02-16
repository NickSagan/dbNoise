//
//  customOverlayView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/26/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardOverlay: UIView {
    
    var basicConstraints = [NSLayoutConstraint]()
    var hearingResultsConstraints = [NSLayoutConstraint]()

    open var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    public var microTitle: UILabel = {
        let label = UILabel()
        label.text = "Micro Title"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    open var continueButton: UIButton = {
        let button = UIButton(type: .system)
        if #available(iOS 15.0, *) {
            button.configuration = .filled()
        } else {
            // Fallback on earlier versions
        }
        button.setTitle("Next", for: .normal)
        button.contentHorizontalAlignment = .center

        return button
    }()
    
    open var resultsList: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Results list", for: .normal)
        button.isHidden = true
        return button
    }()
    
    open var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(nil, for: .normal)
        button.setBackgroundImage(UIImage(named: "closeIcon.png"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.contentHorizontalAlignment = .right
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    open func set(style: SwiftyOnboardStyle) {
        switch style {
        case .dark:
//            continueButton.setTitleColor(.white, for: .normal)
            skipButton.setTitleColor(.white, for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor.white
            microTitle.textColor = .white
            resultsList.setTitleColor(.white, for: .normal)
        case .light:
//            continueButton.setTitleColor(.black, for: .normal)
            skipButton.setTitleColor(.black, for: .normal)
            pageControl.currentPageIndicatorTintColor = UIColor.black
            microTitle.textColor = .black
            resultsList.setTitleColor(.black, for: .normal)
        }
    }
    
    open func page(count: Int) {
        pageControl.numberOfPages = count
    }
    
    open func currentPage(index: Int) {
        pageControl.currentPage = index
    }
    
    public func setUpBasicConstraints() {
        let margin = self.layoutMarginsGuide
        basicConstraints = [
            pageControl.heightAnchor.constraint(equalToConstant: 15),
            pageControl.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: 0),
            pageControl.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 0),
            pageControl.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 0),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10),
            continueButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -16),
            microTitle.heightAnchor.constraint(equalToConstant: 80),
            microTitle.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -2),
            microTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10),
            microTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10),
            skipButton.heightAnchor.constraint(equalToConstant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 30),
            skipButton.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
            skipButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10)
        ]
        NSLayoutConstraint.deactivate(hearingResultsConstraints)
        NSLayoutConstraint.activate(basicConstraints)
    }
    
    public func setUpResultListConstraints() {
        let margin = self.layoutMarginsGuide
        
        hearingResultsConstraints = [
            pageControl.heightAnchor.constraint(equalToConstant: 15),
            pageControl.bottomAnchor.constraint(equalTo: margin.bottomAnchor, constant: 0),
            pageControl.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 0),
            pageControl.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 0),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10),
            continueButton.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -16),
            resultsList.heightAnchor.constraint(equalToConstant: 80),
            resultsList.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -2),
            resultsList.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 10),
            skipButton.heightAnchor.constraint(equalToConstant: 30),
            skipButton.widthAnchor.constraint(equalToConstant: 30),
            skipButton.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
            skipButton.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.deactivate(basicConstraints)
        NSLayoutConstraint.activate(hearingResultsConstraints)
    }
    
    func setUp() {
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(microTitle)
        microTitle.translatesAutoresizingMaskIntoConstraints = false
        microTitle.isHidden = true
        self.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(resultsList)
        resultsList.translatesAutoresizingMaskIntoConstraints = false

        setUpBasicConstraints()
    }
    
}
