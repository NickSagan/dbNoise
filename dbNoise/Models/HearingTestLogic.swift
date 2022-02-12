//
//  HearingTestLogic.swift
//  dbNoise
//
//  Created by Nick Sagan on 02.02.2022.
//

import Foundation
import AVFAudio
import MediaPlayer

protocol HearingTestLogicDelegate {
    func getHearingTest(_ result: HearingResult)
    func getProgress(value: Float)
}

class HearingTestLogic {
    
    var delegate: HearingTestLogicDelegate?
    
    private var hearingTestTimer = Timer()
    var isInProgress: Bool = false
    private var testSound = HearingTestSound()
    private var currentSideInHearingTest: String = "left"
    private let sides: [String] = ["right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left", "right", "left"]
    var leftEarScore: Int = 0
    var rightEarScore: Int = 0
    private var isScoreBlocked: Bool = true
    var progress: Float = 0.01
    
    func start() {
        hearingTestTimer.invalidate()
        rightEarScore = 0
        leftEarScore = 0
        var counter = 0
        progress = 0.01
        var localSides = sides
        localSides.shuffle()
        isInProgress = true

        hearingTestTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            
            MPVolumeView.setHearingVolume(Float.random(in: 0.01...0.5))
            if !localSides.isEmpty {
                self.currentSideInHearingTest = localSides.removeLast()
            } else {
                print("Error: localSides array is empty")
            }
            
            self.testSound.play(self.currentSideInHearingTest)
            self.isScoreBlocked = false
            self.progress += 0.05
            
            self.delegate?.getProgress(value: self.progress)

            counter += 1
            
            print("Timer iteration number: \(counter)")
            print(localSides.count)
            
            if counter >= 20 {
                self.hearingTestTimer.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.finish()
                }
            }
        })
    }
    
    
    func addScore(swipeDirection: String) {
        
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
    
    func finish() {
        isInProgress = false
        hearingTestTimer.invalidate()
        let result: HearingResult = packToResult(left: leftEarScore, right: rightEarScore)
        
        // Save new result into array and into Filemanager directory
        var results: Array<HearingResult> = Shared.instance.hearingResults
        results.append(result)
        Shared.instance.hearingResults = results

        delegate?.getHearingTest(result)
    }
    
    func finished() {
        // if user will finish test with back button, or will close app, or something like that. Just to be sure timer is invalidated
        isInProgress = false
        hearingTestTimer.invalidate()
    }
    
    
    // Pack test results into HearingResult object
    
    private func packToResult(left: Int, right: Int) -> HearingResult {

        var x = ((left + right) * 5) - Int.random(in: 3...9)
        if x < 0 {
            x = 0
        }
        let hearingCompare = "Your hearing is better than \(x)% of users"
        let subtitleText: String!
        
        if x > 50 {
            subtitleText = "You have no hearing impairment"
        } else {
            subtitleText = "You have hearing impairment. Try to visit a doctor"
        }
        
        return HearingResult(date: Date().dateString(), leftEar: left, rightEar: right, leftPercent: "\(Int(left*10))%", rightPercent: "\(Int(right*10))%", subtitleText: subtitleText, hearingCompare: hearingCompare, xForKnob: x)
    }
}
