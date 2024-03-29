//
//  NoiseDetectorViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 27.01.2022.
//

import UIKit
import StoreKit

class NoiseDetectorVC: UIViewController {
    
    @IBOutlet weak var proButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var dbResultLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var textExplanationLabel: UILabel!
    @IBOutlet weak var roundProgressBar: RoundProgressBar!
 
    let item: UIBarButtonItem = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        btn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let item  = UIBarButtonItem(customView: btn)
        
        return item
    }()
    
    let micManager = MicManager()
    let decibelLimit: Double = 140
    var upperLimit: Double = 110
    var interval: Double = 0.2
    var minimal: Int = 141
    var maximal: Int = 0
    var avereage: Int = 40
    
    var results: [NoiseResult]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        micManager.delegate = self
        micManager.interval = interval
        
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let item  = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(item, animated: true)
        
        textExplanationLabel.layer.masksToBounds = true
        textExplanationLabel.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        results = Shared.instance.noiseResults
    }
    
    
    @IBAction func recordPressed(_ sender: UIButton) {
        
        if micManager.isAudioEngineRunning {
            DispatchQueue.main.async {
                sender.setBackgroundImage(UIImage(named: "Rec.png"), for: .normal)
            }
            
            if let url = micManager.getRecordingUrl() {
                micManager.stopRecording()
                showProgress(maximal)
                dbResultLabel.text = "\(maximal)"
                results.append(NoiseResult(date: Date().dateStringNoTime(), min: self.minimal, avg: self.avereage, max: self.maximal, url: url))
                Shared.instance.noiseResults = results
                
                maximal = 0
                minimal = 141
                avereage = 40
                
                // Rate app if 1st time
                if (UserDefaults.standard.bool(forKey: "firstRate") == false) {
                    UserDefaults.standard.set(true, forKey: "firstRate")
                    rateApp()
                }
            }
        } else {
            micManager.checkForPermission { (success) in
                if success {
                    DispatchQueue.main.async {
                        sender.setBackgroundImage(UIImage(named: "Rec-2.png"), for: .normal)
                    }
                    self.micManager.startRecording()

                } else {
                    DispatchQueue.main.async {
                        sender.setBackgroundImage(UIImage(named: "Rec-2.png"), for: .normal)
                    }
                }
            }
        }

    }
    
    @objc func settingsPressed(_ sender: UIButton) {
        let vc = SettingsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func proPressed(_ sender: UIButton) {
        let vc = FreeTrialVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func hearingPressed(_ sender: UIButton) {
        let vc = HearingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        let vc = MyRatingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showProgress(_ value: Int) {
        var progressValue: Float = Float(value) / 140.0
        if progressValue < 0.0 { progressValue = 0.0 }
        if progressValue > 1.0 { progressValue = 1.0 }
        roundProgressBar.progress = progressValue
    }
}

extension NoiseDetectorVC: MicManagerDelegate {
    
    func audioRecordingFailed() {
        print("failed")
    }
    
    func peakAudioVolumeResult(_ value: Int) {
        
        if maximal < value {
            maximal = value
        }
        maxLabel.text = "\(maximal) max"
        showProgress(value)
    }
    
    func avgAudioVolumeResult(_ value: Int) {
        
        if minimal > value {
            minimal = value
        }
        
        avereage = (maximal - minimal) / 2
        
        minLabel.text = "\(minimal) min"
        avgLabel.text = "\(avereage) avg"
        dbResultLabel.text = "\(value)"
        
        var explanation: String = "quiet conversation level"
        switch avereage {
            case 0...40: explanation = "whisper in a quiet place"
            case 41...50: explanation = "quiet conversation level"
            case 51...60: explanation = "office norm"
            case 61...70: explanation = "normal conversation level"
            case 71...80: explanation = "lecture"
            case 81...85: explanation = "Scream, loud conversation"
            case 86...141: explanation = "busy traffic"
        default: explanation = "Scream from hell"
        }
        
        textExplanationLabel.text = explanation
    }
}

// Rate App
extension NoiseDetectorVC {
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
