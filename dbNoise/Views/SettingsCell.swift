//
//  SettingsCell.swift
//  dbNoise
//
//  Created by Nick Sagan on 15.03.2022.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    private let icon : UIImageView = {
        let icon = UIImageView()
        icon.frame.size.height = 28
        icon.frame.size.width = 28
        return icon
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.frame.size.height = 28
        label.frame.size.width = 300
        label.textAlignment = .left
        return label
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(icon)
        addSubview(titleLabel)
        
        icon.widthAnchor.constraint(equalToConstant: 28).isActive = true

        let stackView = UIStackView(arrangedSubviews: [icon, titleLabel])
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
