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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
