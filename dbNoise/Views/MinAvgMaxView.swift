//
//  MinAvgMaxView.swift
//  dbNoise
//
//  Created by Nick Sagan on 12.02.2022.
//

import UIKit

class MinAvgMaxView: UIView {
    
    let minLabel: UILabel = {
        let label = UILabel()
        label.text = "Min"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.frame.size.height = 20
        return label
    }()
    
    let avgLabel: UILabel = {
        let label = UILabel()
        label.text = "Avg"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.frame.size.height = 20
        return label
    }()
    
    let maxLabel: UILabel = {
        let label = UILabel()
        label.text = "Max"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.frame.size.height = 20
        return label
    }()
    
    let minValueLabel: UILabel = {
        let label = UILabel()
        label.text = "40 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.frame.size.height = 33
        return label
    }()
    
    let avgValueLabel: UILabel = {
        let label = UILabel()
        label.text = "48 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.frame.size.height = 33
        return label
    }()
    
    let maxValueLabel: UILabel = {
        let label = UILabel()
        label.text = "90 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.frame.size.height = 33
        return label
    }()
    
    let green: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 52/255.0, green: 199/255.0, blue: 89/255.0, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    let yellow: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255.0, green: 159/255.0, blue: 10/255.0, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
    let red: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255.0, green: 69/255.0, blue: 58/255.0, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()
    
//    let stack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.distribution = .fillEqually
//        stack.alignment = .center
//        stack.spacing = 11.0
//        return stack
//    } ()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setAppearance()
    }
    
    func setUp() {
        let margin = self.layoutMarginsGuide

        self.addSubview(green)
        self.addSubview(yellow)
        self.addSubview(red)
        
        green.addSubview(minValueLabel)
        green.addSubview(minLabel)
        yellow.addSubview(avgValueLabel)
        yellow.addSubview(avgLabel)
        red.addSubview(maxValueLabel)
        red.addSubview(maxLabel)

        green.translatesAutoresizingMaskIntoConstraints = false
        yellow.translatesAutoresizingMaskIntoConstraints = false
        red.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minValueLabel.translatesAutoresizingMaskIntoConstraints = false
        avgLabel.translatesAutoresizingMaskIntoConstraints = false
        avgValueLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: - CONSTRAINTS
        
        let constraints: [NSLayoutConstraint] = [
            green.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            yellow.leadingAnchor.constraint(equalTo: green.trailingAnchor, constant: 20),
            red.leadingAnchor.constraint(equalTo: yellow.trailingAnchor, constant: 20),
            red.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            
            green.widthAnchor.constraint(equalTo: yellow.widthAnchor),
            yellow.widthAnchor.constraint(equalTo: red.widthAnchor),

            green.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
            yellow.centerYAnchor.constraint(equalTo: margin.centerYAnchor),
            red.centerYAnchor.constraint(equalTo: margin.centerYAnchor),

            minValueLabel.leadingAnchor.constraint(equalTo: green.leadingAnchor),
            minValueLabel.topAnchor.constraint(equalTo: green.topAnchor, constant: 10),
            minValueLabel.trailingAnchor.constraint(equalTo: green.trailingAnchor),
            minLabel.topAnchor.constraint(equalTo: minValueLabel.bottomAnchor, constant: 10),
            minLabel.leadingAnchor.constraint(equalTo: green.leadingAnchor),
            minLabel.trailingAnchor.constraint(equalTo: green.trailingAnchor),
            minLabel.bottomAnchor.constraint(equalTo: green.bottomAnchor, constant: -8),
            
            avgValueLabel.leadingAnchor.constraint(equalTo: yellow.leadingAnchor),
            avgValueLabel.topAnchor.constraint(equalTo: yellow.topAnchor, constant: 10),
            avgValueLabel.trailingAnchor.constraint(equalTo: yellow.trailingAnchor),
            avgLabel.topAnchor.constraint(equalTo: avgValueLabel.bottomAnchor, constant: 10),
            avgLabel.leadingAnchor.constraint(equalTo: yellow.leadingAnchor),
            avgLabel.trailingAnchor.constraint(equalTo: yellow.trailingAnchor),
            avgLabel.bottomAnchor.constraint(equalTo: yellow.bottomAnchor, constant: -8),
            
            maxValueLabel.leadingAnchor.constraint(equalTo: red.leadingAnchor),
            maxValueLabel.topAnchor.constraint(equalTo: red.topAnchor, constant: 10),
            maxValueLabel.trailingAnchor.constraint(equalTo: red.trailingAnchor),
            maxLabel.topAnchor.constraint(equalTo: maxValueLabel.bottomAnchor, constant: 10),
            maxLabel.leadingAnchor.constraint(equalTo: red.leadingAnchor),
            maxLabel.trailingAnchor.constraint(equalTo: red.trailingAnchor),
            maxLabel.bottomAnchor.constraint(equalTo: red.bottomAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    //MARK: - APPEARANCE
    
    func setAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = .black
        } else { self.backgroundColor = .white }
    }
}
