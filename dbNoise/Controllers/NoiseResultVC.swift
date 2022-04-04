//
//  NoiseResultVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 17.02.2022.
//

import UIKit
import AVFoundation

class NoiseResultVC: UIViewController {
    
    var result: NoiseResult!
    var myPlayer = AVAudioPlayer()
    
    let header: MinAvgMaxView = {
        let view = MinAvgMaxView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var peak: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.systemGray4
        return view
    }()
    
    var peakLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .white
        lbl.text = ""
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.textAlignment = .center
        lbl.frame.size.height = 33
        return lbl
    }()
    
    var playButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("  Play", for: .normal)
        view.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.titleLabel?.font = view.titleLabel?.font.withSize(26)
        view.tintColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        title = "Result"
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        subviews()
        constraints()
        
        header.minValueLabel.text = "\(result.min) dB"
        header.avgValueLabel.text = "\(result.avg) dB"
        header.maxValueLabel.text = "\(result.max) dB"
        
        peakLabel.text = "Peak: \(result.max) dB"
    }
    
    @objc func playPressed() {
        myPlayer.volume = 1.0
   
//        do {
//            let url = result.url
//            let isReachable = try url.checkResourceIsReachable()
//        } catch let e {
//            print("couldnt load file \(e.localizedDescription)")
//        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            myPlayer = try AVAudioPlayer(contentsOf: result.url)
            myPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func sharePressed() {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        let items: [UIImage] = [image]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.excludedActivityTypes = [.airDrop, .addToReadingList, .openInIBooks, .saveToCameraRoll]
        present(ac, animated: true)
    }
}

extension NoiseResultVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(peak)
        peak.addSubview(peakLabel)
        view.addSubview(playButton)
    }
    
    func constraints() {
        
        NSLayoutConstraint.activate([
            peak.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            peak.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            peak.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            peak.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            peakLabel.centerXAnchor.constraint(equalTo: peak.centerXAnchor),
            peakLabel.centerYAnchor.constraint(equalTo: peak.centerYAnchor),
            
            header.topAnchor.constraint(equalTo: peak.bottomAnchor, constant: 10),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            playButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
