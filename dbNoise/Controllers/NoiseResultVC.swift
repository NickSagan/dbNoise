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
        return lbl
    }()
    
    var playButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Play", for: .normal)
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
        
        header.minValueLabel.text = "\(result.min) dB
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
            peak.topAnchor.constraint(equalTo: view.topAnchor),
            peak.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            peak.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            peak.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            peakLabel.centerXAnchor.constraint(equalTo: peak.centerXAnchor),
            peakLabel.centerYAnchor.constraint(equalTo: peak.centerYAnchor),
            
            header.topAnchor.constraint(equalTo: peak.bottomAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            playButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            playButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
