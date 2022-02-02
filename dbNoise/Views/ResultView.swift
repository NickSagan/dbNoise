//
//  ResultView.swift
//  dbNoise
//
//  Created by Nick Sagan on 02.02.2022.
//

import UIKit

class ResultView: UIView {
    @IBOutlet weak var leftResult: UILabel!
    @IBOutlet weak var rightResult: UILabel!
    @IBOutlet weak var knobCircle: UIImageView!
    @IBOutlet weak var hearingIsBetter: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }

    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "ResultView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)

        // custom initialization logic
        
    }

}
