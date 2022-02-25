//
//  NoiseResultVC.swift
//  dbNoise
//
//  Created by Nick Sagan on 17.02.2022.
//

import UIKit
import MiniPlayer
import AVFoundation

class NoiseResultVC: UIViewController {
    
    var result: NoiseResult!
    
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
    
    var player: MiniPlayer = {
        let player = MiniPlayer()
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player.delegate = self
        player.soundTrack = AVPlayerItem(url: result.url)
        
        print(result!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        title = "Result"
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = .black
        } else {
            view.backgroundColor = .white
        }
        
        subviews()
        constraints()
    }
    
    @objc func sharePressed() {
        // render UIView into UIImage
        // https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        let items: [UIImage] = [image]
        
        // let items: [Any] = ["Look at my hearing test result:", image, URL(string: "https://dbnoiseapp.com")!]
        
        // https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.excludedActivityTypes = [.airDrop, .addToReadingList, .openInIBooks, .saveToCameraRoll]
        present(ac, animated: true)
    }
    
}
extension NoiseResultVC {
    
    func subviews() {
        view.addSubview(header)
        view.addSubview(peak)
        view.addSubview(player)
//        view.addSubview(audioRecord)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            peak.topAnchor.constraint(equalTo: view.topAnchor),
            peak.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            peak.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            peak.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            header.topAnchor.constraint(equalTo: peak.bottomAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            player.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            player.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            player.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
}

extension NoiseResultVC: MiniPlayerDelegate {
    func didPlay(player: MiniPlayer) {
        print("Playing...")
    }
    
    func didStop(player: MiniPlayer) {
        print("Stopped")
    }
    
    func didPause(player: MiniPlayer) {
        print("Pause")
    }
}
