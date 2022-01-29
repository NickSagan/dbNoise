//
//  HearingViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 29.01.2022.
//

import UIKit
import SwiftyOnboard

class HearingViewController: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!

    let onboardTitle: String = "Hearing level"
    let onboardSubTitleArray: [String] = ["Wear the headset for accurate measurement", "Set your phone volume to 50%", "Swap left or right when you hear sound from one side or the other"]
    let microText: String = "Despite its accuracy, this device is not a medical device. See your GP"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        

        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .white
        }
        view.addSubview(swiftyOnboard)
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
        
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = swiftyOnboard.currentPage
        if index == 2 {
            print("Start hearing test")
        } else {
            print("Next")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
    }
    
    @objc func handleSkip() {
//        let index = swiftyOnboard.currentPage
//        if index == 2 {
//            print("Skip Onboarding - go to main stuff")
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "NoiseDetectorID")
//            let nc = UINavigationController(rootViewController: vc)
//            nc.modalPresentationStyle = .overFullScreen
//            present(nc, animated: true, completion: nil)
//
//        } else {
//            print("Skip to last page")
//            swiftyOnboard?.goToPage(index: 2, animated: true)
//        }
    }
}

//MARK: - SwiftyOnboard protocols

extension HearingViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    

    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()

        page.title.text = onboardTitle
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        page.subTitle.text = onboardSubTitleArray[index]
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 22)
        
        page.updateTopAnchor()
 
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .white
        }
        
        if index == 1 {
            
        } else {
            page.imageView.image = UIImage(named: "\(index)hearing.png")
        }
        
        return page
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        //Setup for the overlay buttons:
        overlay.microTitle.text = microText
        overlay.microTitle.isHidden = false
        overlay.microTitle.tintColor = UIColor(cgColor: CGColor(red: 60, green: 60, blue: 67, alpha: 0.3))
        overlay.microTitle.font = UIFont(name: "SFProDisplay-Light", size: 10)
        
        overlay.skipButton.isHidden = true
        
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
        overlay.continueButton.tag = Int(position)

        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.continueButton.setTitle("Next", for: .normal)
 
        } else {
            overlay.continueButton.setTitle("Start Test", for: .normal)
    
        }
    }
}
