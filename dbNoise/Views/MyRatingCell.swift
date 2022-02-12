//
//  MyRatingCell.swift
//  dbNoise
//
//  Created by Nick Sagan on 11.02.2022.
//

import UIKit

class MyRatingCell : UITableViewCell {

    var result : NoiseResult? {
        didSet {
            if let res = result {
                dateLabel.text = res.date
                minLabel.text = "\(res.min) Min"
                avgLabel.text = "\(res.avg) Avg"
                maxLabel.text = "\(res.max) Max"
            } else {
                print("Error recieving result data")
                dateLabel.text = "No date"
                minLabel.text = "00 Min"
                avgLabel.text = "00 Avg"
                maxLabel.text = "00 Max"
            }
        }
    }
    
    
    private let dateLabel : UILabel = {
        let date = UILabel()
        date.frame.size.height = 20
        date.frame.size.width = 260
        date.textAlignment = .left
        return date
    }()
    
    
    private let minLabel : UILabel = {
        let lbl = UILabel()
        lbl.frame.size.width = 60
        lbl.frame.size.height = 20
        lbl.textColor = .systemGreen
        lbl.backgroundColor = UIColor(cgColor: CGColor(red: 50, green: 192, blue: 85, alpha: 0.1))
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 8.0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let avgLabel : UILabel = {
        let lbl = UILabel()
        lbl.frame.size.width = 60
        lbl.frame.size.height = 20
        lbl.textColor = .systemYellow
        lbl.backgroundColor = UIColor(cgColor: CGColor(red: 50, green: 192, blue: 85, alpha: 0.1))
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 8.0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let maxLabel : UILabel = {
        let lbl = UILabel()
        lbl.frame.size.width = 60
        lbl.frame.size.height = 20
        lbl.textColor = .systemRed
        lbl.backgroundColor = UIColor(cgColor: CGColor(red: 50, green: 192, blue: 85, alpha: 0.1))
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 8.0
        lbl.textAlignment = .center
        return lbl
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(minLabel)
        addSubview(avgLabel)
        addSubview(maxLabel)
        
        minLabel.widthAnchor.constraint(equalTo: maxLabel.widthAnchor).isActive = true
        avgLabel.widthAnchor.constraint(equalTo: maxLabel.widthAnchor).isActive = true

        let stackView = UIStackView(arrangedSubviews: [dateLabel, minLabel, avgLabel, maxLabel])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 15
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: 0, height: 0, enableInsets: false)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
