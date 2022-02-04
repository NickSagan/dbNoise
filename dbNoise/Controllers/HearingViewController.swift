//
//  HearingViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 29.01.2022.
//

import UIKit
import SwiftyOnboard
import AVFAudio
import MediaPlayer

class HearingViewController: UIViewController {
    
    var swiftyOnboard: SwiftyOnboard!
    var page: SwiftyOnboardPage!
    
    var currentVolumeLevel: Float = 0.5
    var headphonesCheckerTimer = Timer()
    let hearingTest = HearingTestLogic()
    
    var knob: UIImageView!
    var progressView = UIProgressView()
    
    var result: ResultView!
    var results: Array<Result> = []
    
    let onboardTitle: String = "Hearing level"
    let onboardSubTitleArray: [String] = ["Wear the headset for accurate measurement", "Set your phone volume to 50%", "Swap left or right when you hear sound from one side or the other", "", "You have no hearing impairment"]
    let microText: String = "Despite its accuracy, this device is not a medical device. See your GP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        results = Shared.instance.results
        print(results)
        
        swiftyOnboard = SwiftyOnboard(frame: view.frame)
        swiftyOnboard.shouldSwipe = false
        
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
        hearingTest.delegate = self
        
        currentVolumeLevel = AVAudioSession.sharedInstance().outputVolume
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute
        
        if currentRoute.outputs.count != 0 {
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones {
                    
                    print("headphone plugged in")
                } else {
                    
                    print("headphone pulled out")
                }
            }
        } else {
            print("requires connection to device")
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(audioRouteChangeListener(_:)),
            name: AVAudioSession.routeChangeNotification,
            object: nil)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        hearingTest.finished()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if hearingTest.isInProgress {
            if gesture.direction == .right {
                hearingTest.addScore(swipeDirection: "right")
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: []) {
                    self.knob.transform = CGAffineTransform(translationX: 120, y: 0)
                } completion: { _ in
                    self.knob.transform = .identity
                }
                
            }
            else if gesture.direction == .left {
                hearingTest.addScore(swipeDirection: "left")
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: []) {
                    self.knob.transform = CGAffineTransform(translationX: -120, y: 0)
                } completion: { _ in
                    self.knob.transform = .identity
                }
            }
        }
    }
    
    @objc dynamic fileprivate func audioRouteChangeListener(_ notification:Notification) {
        let audioRouteChangeReason = notification.userInfo![AVAudioSessionRouteChangeReasonKey] as! UInt
        
        switch audioRouteChangeReason {
        case AVAudioSession.RouteChangeReason.newDeviceAvailable.rawValue:
            print("headphone plugged in")
        case AVAudioSession.RouteChangeReason.oldDeviceUnavailable.rawValue:
            print("headphone pulled out")
        default:
            break
        }
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = swiftyOnboard.currentPage
        
        if index == 0 {
            if AVAudioSession.isHeadphonesConnected {
                headphonesCheckerTimer.invalidate()
                print("Next")
                swiftyOnboard?.goToPage(index: index + 1, animated: true)
            } else {
                print("Please connect your headphones")
            }
        } else if index == 1 {
            MPVolumeView.setVolume(0.5)
            if currentVolumeLevel > 0.38 && currentVolumeLevel < 0.62 {
                swiftyOnboard?.goToPage(index: index + 1, animated: true)
                print("Next")
            } else {
                print("Please set volume to 50%")
                
            }
        } else if index == 2 {
            print("Start hearing test")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
            progressView.progress = 0.01
            hearingTest.start()

        } else if index == 3 {
            print("Finish hearing test")
            hearingTest.finish()
        } else if index == 4 {
            print("Start NEW hearing test")
            swiftyOnboard?.goToPage(index: 0, animated: true)
        }
        
    }
    
    @objc func handleSkip() {
    }
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        currentVolumeLevel = sender.value
        MPVolumeView.setVolume(sender.value)
        
        print("volume: \(currentVolumeLevel)")
    }
}

//MARK: - HearingTestDelegate

extension HearingViewController: HearingTestLogicDelegate {
    
    func getHearingTestResultForEars(left: Int, right: Int) {
        swiftyOnboard?.goToPage(index: 4, animated: true)
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = df.string(from: date)
        
        let newResult = Result(name: "Test name", date: dateString, left: left, right: right)
        
        results.append(newResult)
        Shared.instance.results = results
        
        result.leftResult.text = "\(Int(left*10))%"
        result.rightResult.text = "\(Int(right*10))%"
        var x = ((left + right) * 5) - Int.random(in: 5...9)
        if x < 0 {
            x = 0
        }
        result.hearingIsBetter.text = "Your hearing is better than \(x)% of users"
        
        UIView.animate(withDuration: 0.9, delay: 0.15, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: []) {
            self.result.knobCircle.transform = CGAffineTransform(translationX: CGFloat(-x * 3), y: 0)
        } completion: { _ in
            
        }
        
        if x > 50 {
            self.page.subTitle.text = "You have no hearing impairment"
        } else {
            self.page.subTitle.text = "You have hearing impairment. Try to visit a doctor"
        }
    }
    
    func getProgress(value: Float) {
        progressView.progress = value
    }
}

//MARK: - SwiftyOnboard PAGES

extension HearingViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 5
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        page = SwiftyOnboardPage()
        
        page.title.text = onboardTitle
        page.title.font = UIFont(name: "SFProDisplay-Bold", size: 34)
        page.subTitle.text = onboardSubTitleArray[index]
        page.subTitle.font = UIFont(name: "SFProDisplay-Light", size: 22)
        
        page.updateTopAnchor() // fix for UINavBar
        
        if traitCollection.userInterfaceStyle == .dark {
            swiftyOnboard.style = .dark
            swiftyOnboard.backgroundColor = .black
        } else {
            swiftyOnboard.style = .light
            swiftyOnboard.backgroundColor = .white
        }
        
        if index == 0 {
            page.imageView.image = UIImage(named: "\(index)hearing.png")
            
        } else if index == 1 {
            let slider = UISlider(frame: CGRect(x: view.frame.size.width * 0.1, y: view.frame.height * 0.4, width: view.frame.size.width * 0.8, height: 44))
            
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            slider.isContinuous = true
            slider.value = AVAudioSession.sharedInstance().outputVolume
            slider.isEnabled = true
            slider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
            
            let ellipse = UIImageView(frame: CGRect(x: (view.frame.size.width * 0.4) - 32, y: -10, width: 65, height: 65))
            ellipse.image = UIImage(named: "ellipse")
            //ellipse.backgroundColor?.withAlphaComponent(0)
            slider.addSubview(ellipse)
            
            page.addSubview(slider)
            
            
        } else if index == 2 {
            page.imageView.image = UIImage(named: "\(index)hearing.png")
        } else if index == 3 {
            page.updateToHearingConstraints()
            page.imageView.image = UIImage(named: "\(index)hearing.png")
            knob = UIImageView(image: UIImage(named: "knob.png"))
            knob.translatesAutoresizingMaskIntoConstraints = false
            
            page.imageView.addSubview(knob)
            
            knob.centerYAnchor.constraint(equalTo: page.imageView.centerYAnchor).isActive = true
            knob.centerXAnchor.constraint(equalTo: page.imageView.centerXAnchor).isActive = true
            knob.widthAnchor.constraint(equalToConstant: 84).isActive = true
            knob.heightAnchor.constraint(equalToConstant: 84).isActive = true
            
            progressView.translatesAutoresizingMaskIntoConstraints = false
            page.addSubview(progressView)
            progressView.leadingAnchor.constraint(equalTo: page.leadingAnchor, constant: 15).isActive = true
            progressView.trailingAnchor.constraint(equalTo: page.trailingAnchor, constant: -15).isActive = true
            progressView.topAnchor.constraint(equalTo: page.imageView.bottomAnchor, constant: 20).isActive = true
            progressView.progress = 0.01
            
        } else if index == 4 {
            result = ResultView(frame: CGRect(x: view.frame.size.width * 0.05, y: 0, width: 350, height: 300))
            page.imageView.addSubview(result)
//            page.imageView.backgroundColor = .gray
        }
        return page
    }
    
//MARK: - SwiftyOnboard OVERLAY
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = SwiftyOnboardOverlay()
        
        //Setup targets for the buttons on the overlay view:
        overlay.skipButton.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay.continueButton.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        
        overlay.microTitle.text = microText
        overlay.microTitle.isHidden = false
        overlay.microTitle.tintColor = UIColor(cgColor: CGColor(red: 60, green: 60, blue: 67, alpha: 0.3))
        overlay.microTitle.font = UIFont(name: "SFProDisplay-Light", size: 10)
        
        overlay.skipButton.isHidden = true
        
        if AVAudioSession.isHeadphonesConnected {
            overlay.continueButton.isEnabled = true
        } else {
            overlay.continueButton.isEnabled = false
        }
        
        headphonesCheckerTimer.invalidate()
        headphonesCheckerTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if AVAudioSession.isHeadphonesConnected {
                overlay.continueButton.isEnabled = true
            } else {
                overlay.continueButton.isEnabled = false
            }
        })
        
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.continueButton.tag = Int(position)
        
        if currentPage == 0.0 {
            overlay.continueButton.setTitle("Next", for: .normal)
            overlay.pageControl.isHidden = false
            overlay.microTitle.isHidden = false
        } else if currentPage == 1.0 {
            headphonesCheckerTimer.invalidate()
            overlay.continueButton.setTitle("Next", for: .normal)
            overlay.continueButton.isEnabled = true
        } else if currentPage == 2.0 {
            overlay.continueButton.setTitle("Start Test", for: .normal)
            overlay.continueButton.isEnabled = true
        } else if currentPage == 3.0 {
            overlay.continueButton.setTitle("Stop Test", for: .normal)
            overlay.continueButton.isEnabled = true
            overlay.pageControl.isHidden = true
        } else if currentPage == 4.0 {
            overlay.continueButton.setTitle("Start new Test", for: .normal)
            overlay.continueButton.isEnabled = true
            overlay.pageControl.isHidden = true
            overlay.microTitle.isHidden = true
        }
    }
}
