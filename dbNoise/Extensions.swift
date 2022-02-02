//
//  Extensions.swift
//  dbNoise
//
//  Created by Nick Sagan on 02.02.2022.
//

import Foundation
import AVFAudio
import MediaPlayer

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
