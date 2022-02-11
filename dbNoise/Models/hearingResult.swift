//
//  HearingResult.swift
//  dbNoise
//
//  Created by Nick Sagan on 04.02.2022.
//

import Foundation

struct HearingResult: Codable {
    
    let date: String
    let leftEar: Int
    let rightEar: Int
    let leftPercent: String
    let rightPercent: String
    let subtitleText: String
    let hearingCompare: String
    let xForKnob: Int
}

