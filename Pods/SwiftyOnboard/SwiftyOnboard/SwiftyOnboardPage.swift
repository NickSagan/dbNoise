//
//  customPageView.swift
//  SwiftyOnboard
//
//  Created by Jay on 3/25/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

open class SwiftyOnboardPage: UIView {
    
    var noNavBarConstraints = [NSLayoutConstraint]()
    var withNavBarConstraints = [NSLayoutConstraint]()
    var hearingConstraints = [NSLayoutConstraint]()
    
    public var title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    public var subTitle: UILabel = {
        let label = UILabel()
        label.text = "Sub Title"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    
    public var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    func set(style: SwiftyOnboardStyle) {
        switch style {
        case .dark:
            title.textColor = .white
            subTitle.textColor = .white
        case .light:
            title.textColor = .black
            subTitle.textColor = .black
        }
    }
    
    // To fix lead\trail anchors constrainst, while using nav controller and at page: HEARING TESTING
    public func updateToHearingConstraints() {
        let margin = self.layoutMarginsGuide
        
        hearingConstraints = [
            title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 14),
            title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30),
            title.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 41),
            
            imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 38),
            imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -37),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5),
            
            subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 13),
            subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -13),
            subTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            subTitle.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.deactivate(withNavBarConstraints)
        NSLayoutConstraint.activate(hearingConstraints)
    }
    
    // To fix top anchor constraint, while using nav controller
    public func updateTopAnchor() {
        let margin = self.layoutMarginsGuide
        
        withNavBarConstraints = [
            title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 14),
            title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30),
            title.topAnchor.constraint(equalTo: margin.topAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 41),
            
            imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: -8),
            imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5),
            
            subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 13),
            subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -13),
            subTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            subTitle.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.deactivate(noNavBarConstraints)
        NSLayoutConstraint.activate(withNavBarConstraints)
    }
    
    func setUp() {
        self.addSubview(imageView)
        self.addSubview(title)
        self.addSubview(subTitle)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let margin = self.layoutMarginsGuide
        
        noNavBarConstraints = [
            title.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 14),
            title.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -30),
            title.topAnchor.constraint(equalTo: margin.topAnchor, constant: 31),
            title.heightAnchor.constraint(equalToConstant: 41),
            
            imageView.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: -8),
            imageView.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: 8),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo: margin.heightAnchor, multiplier: 0.5),
            
            subTitle.leftAnchor.constraint(equalTo: margin.leftAnchor, constant: 13),
            subTitle.rightAnchor.constraint(equalTo: margin.rightAnchor, constant: -13),
            subTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            subTitle.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(noNavBarConstraints)
    }
}
