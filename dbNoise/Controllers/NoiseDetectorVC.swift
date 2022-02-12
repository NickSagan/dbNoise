//
//  NoiseDetectorViewController.swift
//  dbNoise
//
//  Created by Nick Sagan on 27.01.2022.
//

import UIKit

class NoiseDetectorVC: UIViewController {
    
    @IBOutlet weak var proButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var dbResultLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var textExplanationLabel: UILabel!
    
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
        results = Shared.instance.noiseResults
        
        micManager.delegate = self
        micManager.interval = interval
        
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        btn.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
        let item  = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(item, animated: true)
        
        textExplanationLabel.layer.masksToBounds = true
        textExplanationLabel.layer.cornerRadius = 5
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    
    @IBAction func recordPressed(_ sender: UIButton) {
        
        if micManager.isAudioEngineRunning {
            DispatchQueue.main.async {
                sender.setBackgroundImage(UIImage(named: "Rec.png"), for: .normal)
            }
            micManager.stopRecording()
            results.append(NoiseResult(date: Date().dateString(), min: self.minimal, avg: self.avereage, max: self.maximal))
            Shared.instance.noiseResults = results
            
            maximal = 0
            minimal = 141
            avereage = 40
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
        print("settings")
    }
    
    @IBAction func proPressed(_ sender: UIButton) {
        print("pro")
    }
    
    @IBAction func hearingPressed(_ sender: UIButton) {
        let vc = HearingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func menuPressed(_ sender: UIButton) {
        let vc = MyRatingVC()
        navigationController?.pushViewController(vc, animated: true)
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
