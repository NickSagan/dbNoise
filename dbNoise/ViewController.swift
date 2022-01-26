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
    let paymentText: String = "Payment will be charged to your iTunes Account at confirmation of purchase. Subscriptions will automatically renew unless auto-renew is turned off at least 24 hours before the end of the period. Your account will be charged for renewal according to your plan within 24 hours prior to the end of the current period. You can control or turn off auto-renewal by going to your Apple ID account settings at any time after purchase."
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = swiftyOnboard.currentPage
        if index == 2 {
            print("Start using (Subscribe)")
        } else {
            print("Next")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
    }
    
    @objc func handleSkip() {
        let index = swiftyOnboard.currentPage
        if index == 2 {
            print("Skip Onboarding")
        } else {
            print("Skip to last page")
            swiftyOnboard?.goToPage(index: 2, animated: true)
        }
    }
}

//MARK: - SwiftyOnboard protocols

extension ViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
        
        page.title.text = onboardTitleArray[index]
        page.subTitle.text = onboardSubTitleArray[index]
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 22)
        
        page.imageView.image = UIImage(named: "\(index).png")
        
        return page
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
//        overlay.continueButton.titleLabel?.font = UIFont(name: "Lato-Bold", size: 16)
//        overlay.continueButton.setTitleColor(UIColor.white, for: .normal)
//        overlay.skipButton.setTitleColor(UIColor.white, for: .normal)
//        overlay.skipButton.titleLabel?.font = UIFont(name: "Lato-Heavy", size: 16)
//
        //Return the overlay view:
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        print(Int(currentPage))
        overlay.continueButton.tag = Int(position)
        overlay.microTitle.text = paymentText
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Next", for: .normal)
            overlay.skipButton.setTitle("Skip", for: .normal)
            overlay.skipButton.isHidden = true
            overlay.microTitle.isHidden = true
        } else {
            overlay.continueButton.setTitle("Start using", for: .normal)
            overlay.skipButton.isHidden = false
            overlay.microTitle.isHidden = false
        }
    }
    
}

