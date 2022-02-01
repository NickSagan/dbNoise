//
//  HearingTestSound.swift
//  dbNoise
//
//  Created by Nick Sagan on 01.02.2022.
//

import Foundation
import AVFoundation

class HearingTestSound {
    
    fileprivate var player = AVAudioPlayer()
    fileprivate var volume: Float = 0.5
    fileprivate var soundName: String = "r1"
    
    func play(_ sound: String) {
        // Set random volume
        volume = Float.random(in: 0.03...0.5)
        player.volume = volume
        
        // Generate random sound name
        if sound == "left" {
            soundName = "l\(Int.random(in: 1...2))"
        } else if sound == "right" {
            soundName = "r\(Int.random(in: 1...2))"
        } else {
            print("Can't play this sound. Input: left or right")
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
