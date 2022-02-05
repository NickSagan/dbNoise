//
//  ResultListCell.swift
//  dbNoise
//
//  Created by Nick Sagan on 05.02.2022.
//

import UIKit

class ResultListCell : UITableViewCell {

    var result : Result? {
        didSet {
            dateLabel.text = result?.date
            leftEarLabel.text = "\(result?.leftEar ?? 0) L"
            rightEarLabel.text = "\(result?.rightEar ?? 0) R"
        }
    }
    
    
    private let dateLabel : UILabel = {
        let date = UILabel()
        date.frame.size.height = 20
        date.frame.size.width = 260
        date.textAlignment = .left
        return date
    }()
    
    
    private let leftEarLabel : UILabel = {
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
    
    private let rightEarLabel : UILabel = {
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
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateLabel)
        addSubview(leftEarLabel)
        addSubview(rightEarLabel)
        
        leftEarLabel.widthAnchor.constraint(equalTo: rightEarLabel.widthAnchor).isActive = true

        let stackView = UIStackView(arrangedSubviews: [dateLabel, leftEarLabel, rightEarLabel])
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
