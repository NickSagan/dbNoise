//
//  MicManager.swift
//  dbNoise
//
//  Created by Nick Sagan on 28.01.2022.
//

import Foundation
import AVKit

protocol MicManagerDelegate {
    func audioRecordingFailed()
    func avgAudioVolumeResult(_ value: Int)
    func peakAudioVolumeResult(_ value: Int)
}

// https://github.com/stevenysjo/DecibelMeter
//
// This class will manage input audio and return dB values

class MicManager: NSObject {
    let audioSession = AVAudioSession.sharedInstance()
    var delegate: MicManagerDelegate?
    private let audioEngine = AVAudioEngine()

    private var recorder : AVAudioRecorder? = nil
    private var timer: Timer?
    var interval: Double = 0.2

    func getDocumentsDirectory() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls.first!
        return documentDirectory.appendingPathComponent("recording\(IDFabric.shared.getID()).m4a")
    }
    
    var isAudioEngineRunning: Bool {
        return self.recorder?.isRecording == true
    }
    
    func checkForPermission(_ result: @escaping (_ success: Bool)->()) {
        switch audioSession.recordPermission {
        case .granted:
            initRecorder()
            result(true)
        case .denied: result(false)
        case .undetermined:
            audioSession.requestRecordPermission { _ in
                self.checkForPermission(result)
            }
        @unknown default:
            result(false)
        }
    }

    func initRecorder() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord)
            try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            try session.setActive(true)
            
            try recorder = AVAudioRecorder(url: getDocumentsDirectory(), settings: settings)
            recorder?.delegate = self
            recorder?.isMeteringEnabled = true
            if recorder?.prepareToRecord() != true {
                print("Error: AVAudioRecorder prepareToRecord failed")
            }
        } catch {
            print("Error: AVAudioRecorder creation failed")
        }
    }
    
    func getRecordingUrl() -> URL? {
        return recorder?.url
    }
    
    func startRecording() {
        recorder?.record()
        startTimer()
    }
    
    func stopRecording() {
        timer?.invalidate()
        recorder?.stop()
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.getDispersyPercent), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    @objc func getDispersyPercent() {
        recorder?.updateMeters()
//        let db = Double(recorder?.averagePower(forChannel: 0) ?? -160)
//        let result = pow(10.0, db / 20.0)
        delegate?.avgAudioVolumeResult(Int(dBFS_convertTo_dB(dBFSValue: recorder?.averagePower(forChannel: 0) ?? -160) * 140))
        
//        let db2 = Double(recorder?.peakPower(forChannel: 0) ?? -160)
//        let result2 = pow(10.0, db2 / 20.0)
        delegate?.peakAudioVolumeResult(Int(dBFS_convertTo_dB(dBFSValue: recorder?.averagePower(forChannel: 0) ?? -160) * 140))

    }
    
    // https://stackoverflow.com/questions/38246919/how-to-detect-max-db-swift
    
    func dBFS_convertTo_dB (dBFSValue: Float) -> Float
    {
    var level:Float = 0.0
    let peak_bottom:Float = -60.0 // dBFS -> -160..0   so it can be -80 or -60

    if dBFSValue < peak_bottom
    {
        level = 0.0
    }
    else if dBFSValue >= 0.0
    {
        level = 1.0
    }
    else
    {
        let root:Float              =   2.0
        let minAmp:Float            =   powf(10.0, 0.05 * peak_bottom)
        let inverseAmpRange:Float   =   1.0 / (1.0 - minAmp)
        let amp:Float               =   powf(10.0, 0.05 * dBFSValue)
        let adjAmp:Float            =   (amp - minAmp) * inverseAmpRange

        level = powf(adjAmp, 1.0 / root)
    }
    return level
    }
}

extension MicManager: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        recorder.stop()
        //recorder.deleteRecording()
        //recorder.prepareToRecord()
    }
}
