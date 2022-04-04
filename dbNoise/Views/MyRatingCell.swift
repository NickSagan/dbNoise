//
//  MyRatingCell.swift
//  dbNoise
//
//  Created by Nick Sagan on 11.02.2022.
//

import UIKit
import SnapKit

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
        date.frame.size.height = 50
        date.frame.size.width = 200
        date.textAlignment = .center
        return date
    }()
    
    
    private let minLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .systemGreen
        lbl.backgroundColor = UIColor(cgColor: CGColor(red: 50, green: 192, blue: 85, alpha: 0.1))
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 8.0
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let avgLabel : UILabel = {
        let lbl = UILabel()
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
        lbl.frame.size.height = 50
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
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        avgLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(self.snp.width).multipliedBy(0.3)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.width.lessThanOrEqualTo(self.snp.width).multipliedBy(0.22)
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(28)
        }
        
        avgLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.width.equalTo(minLabel.snp.width)
            make.leading.equalTo(minLabel.snp.trailing).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(minLabel.snp.height)
        }
        
        maxLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.width.equalTo(minLabel.snp.width)
            make.leading.equalTo(avgLabel.snp.trailing).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(minLabel.snp.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
