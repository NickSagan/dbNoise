//
//  ViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 26.01.2022.
//

import UIKit
import SwiftyOnboard

class ViewController: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    let onboardTitleArray: [String] = ["Noise level", "Hearing test", "New opportunities"]
    let onboardSubTitleArray: [String] = ["Check the noise level, keep personal statistics. Keep track of the global noise rating.", "Take a hearing test, save the results.  Monitor your hearing. We care about your health.", "Discover all the possibilities for just $6,99 per month"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    
}

//MARK: - SwiftyOnboard protocols

extension ViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        

        page.title.text = onboardTitleArray[index]
        page.subTitle.text = onboardSubTitleArray[index]
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 22)
        
        page.imageView.image = UIImage(named: "onboardLight.jpg")
        
        return page
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Next", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = true
        } else {
            overlay.continueButton.setTitle("Start using", for: .normal)
            overlay.skipButton.isHidden = false
        }
    }
}

