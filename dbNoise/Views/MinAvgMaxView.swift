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
        return label
    }()
    
    let avgLabel: UILabel = {
        let label = UILabel()
        label.text = "Avg"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    let maxLabel: UILabel = {
        let label = UILabel()
        label.text = "Max"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    let minValueLabel: UILabel = {
        let label = UILabel()
        label.text = "4 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    let avgValueLabel: UILabel = {
        let label = UILabel()
        label.text = "48 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    let maxValueLabel: UILabel = {
        let label = UILabel()
        label.text = "90 dB"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    let green: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 12
        return view
    }()
    
    let yellow: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 12
        return view
    }()
    
    let red: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 12
        return view
    }()
    
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
