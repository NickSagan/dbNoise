//
//  HearingTestSound.swift
//  dbNoise
//
//  Created by Nick Sagan on 01.02.2022.
//

import Foundation
import AVFoundation

class HearingTestSound {
    
    var player: AVAudioPlayer?
    
    func play(_ sound: String) {
        let x = Int.random(in: 1...2)
        var randomSound: String = "r1"
        if sound == "left" {
            randomSound = "\(x)l"
        } else if sound == "right" {
            randomSound = "\(x)r"
        } else {
            return
        }
        
        guard let url = Bundle.main.url(forResource: randomSound, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
