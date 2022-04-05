//
//  FreeTrialVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 05.04.2022.
//

import UIKit
import SnapKit

class FreeTrialVC: UIViewController {
    
    var freeTrialView: FreeTrialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        freeTrialView = FreeTrialView()
        freeTrialView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(freeTrialView)
        
        freeTrialView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
