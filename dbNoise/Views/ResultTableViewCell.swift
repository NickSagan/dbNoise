//
//  ResultTableViewCell.swift
//  dbNoise
//
//  Created by Nick Sagan on 05.02.2022.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var right: UILabel!
    @IBOutlet weak var left: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        right.translatesAutoresizingMaskIntoConstraints = false
        left.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(right)
        contentView.addSubview(left)
        contentView.addSubview(date)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //
    //        right.translatesAutoresizingMaskIntoConstraints = false
    //        left.translatesAutoresizingMaskIntoConstraints = false
    //        date.translatesAutoresizingMaskIntoConstraints = false
    //
    //        contentView.addSubview(right)
    //        contentView.addSubview(left)
    //        contentView.addSubview(date)
    //    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
