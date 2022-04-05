//
//  FreeTrialView.swift
//  dbNoise
//
//  Created by Nick Sagan on 05.04.2022.
//

import UIKit
import SnapKit

class FreeTrialView: UIView {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        
        return sv
    }()
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        
        return imgView
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
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.top.equalTo(scrollView.snp.top)
        }
    }
    
    //MARK: - APPEARANCE
    
    func setAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            self.backgroundColor = .black
            imageView.image = UIImage(named: "freeTrialBlackBG")
        } else {
            self.backgroundColor = .white
            imageView.image = UIImage(named: "freeTrialBlackBG")
        }
    }
}
