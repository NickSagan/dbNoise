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
    var currentVolumeLevel: Float = 0.0
    var headphonesCheckerTimer = Timer()
    var hearingTestTimer = Timer()
    var hearingIsInProgress: Bool = false
    var testSound = HearingTestSound()
    var currentSideInHearingTest: String = "left"
    let sides: [String] = ["right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left"]
    var leftEarScore: Int = 0
    var rightEarScore: Int = 0
    var isScoreBlocked: Bool = true
    
    var knob: UIImageView!
    var progress = UIProgressView()
    
    let onboardTitle: String = "Hearing level"
    let onboardSubTitleArray: [String] = ["Wear the headset for accurate measurement", "Set your phone volume to 50%", "Swap left or right when you hear sound from one side or the other", ""]
    let microText: String = "Despite its accuracy, this device is not a medical device. See your GP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if hearingIsInProgress {
            if gesture.direction == .right {
                addScoreToHearingTest(swipeDirection: "right")
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: []) {
                    self.knob.transform = CGAffineTransform(translationX: 120, y: 0)
                } completion: { _ in
                    self.knob.transform = .identity
                }
                
            }
            else if gesture.direction == .left {
                addScoreToHearingTest(swipeDirection: "left")
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
            if currentVolumeLevel > 0.38 && currentVolumeLevel < 0.62 {
                swiftyOnboard?.goToPage(index: index + 1, animated: true)
                print("Next")
            } else {
                print("Please set volume to 50%")
                
            }
        } else if index == 2 {
            print("Start hearing test")
            swiftyOnboard?.goToPage(index: index + 1, animated: true)
            hearingIsInProgress = true
            startHearingTest()
        } else if index == 3 {
            print("Finish hearing test")
            hearingTestTimer.invalidate()
            hearingIsInProgress = true
        }
        
    }
    
    @objc func handleSkip() {
    }
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        currentVolumeLevel = sender.value
        MPVolumeView.setVolume(sender.value)
        
        print("volume: \(currentVolumeLevel)")
    }
    
    func startHearingTest() {
        hearingTestTimer.invalidate()
        rightEarScore = 0
        leftEarScore = 0
        var counter = 0
        progress.progress = 0.01
        var localSides = sides
        localSides.shuffle()

        hearingTestTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            
            MPVolumeView.setHearingVolume(Float.random(in: 0.01...0.5))
            if !localSides.isEmpty {
                self.currentSideInHearingTest = localSides.removeLast()
            } else {
                print("Error: localSides array is empty")
            }
            
            self.testSound.play(self.currentSideInHearingTest)
            self.isScoreBlocked = false
            self.progress.progress += 0.05

            counter += 1
            
            print("Timer iteration number: \(counter)")
            print(localSides.count)
            
            if counter >= 20 {
                self.hearingTestTimer.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.hearingTestFinished()
                }
            }
        })
    }
    
    func addScoreToHearingTest(swipeDirection: String) {
        
        guard !isScoreBlocked else {
            print("Score is blocked: \(isScoreBlocked)")
            return
        }
        
        if currentSideInHearingTest == swipeDirection {
            if currentSideInHearingTest == "left" {
                leftEarScore += 1
            } else {
                rightEarScore += 1
            }
        } else {
            print("Failed in test")
        }
        isScoreBlocked = true
        print("Left ear: \(leftEarScore), right ear: \(rightEarScore), is score blocked: \(isScoreBlocked)")
    }
    
    func hearingTestFinished() {
        self.isScoreBlocked = false
        
        print("FINISH*** Test result is: left \(leftEarScore), right \(rightEarScore)")
    }
}

//MARK: - SwiftyOnboard protocols

extension HearingViewController: SwiftyOnboardDataSource, SwiftyOnboardDelegate {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 4
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = SwiftyOnboardPage()
        
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
            
            progress.translatesAutoresizingMaskIntoConstraints = false
            page.addSubview(progress)
            progress.leadingAnchor.constraint(equalTo: page.leadingAnchor, constant: 15).isActive = true
            progress.trailingAnchor.constraint(equalTo: page.trailingAnchor, constant: -15).isActive = true
            progress.topAnchor.constraint(equalTo: page.imageView.bottomAnchor, constant: 20).isActive = true
            progress.progress = 0.01
            
        }
        
        return page
    }
    
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
        }
    }
}

//MARK: - AVAudioSession extension to check for headphones

extension AVAudioSession {
    
    static var isHeadphonesConnected: Bool {
        return sharedInstance().isHeadphonesConnected
    }
    
    var isHeadphonesConnected: Bool {
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }
    
}

extension AVAudioSessionPortDescription {
    var isHeadphones: Bool {
        return portType == AVAudioSession.Port.headphones
    }
}

//Update system volume https://stackoverflow.com/questions/37873962/setting-the-system-volume-in-swift-under-ios

extension MPVolumeView {
    
    // for slider changing volume
    
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
    
    // and this one for hearing test
    
    static func setHearingVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.001) {
            slider?.value = volume
        }
    }
}
