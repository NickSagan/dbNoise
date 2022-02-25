//
//  NoiseResult.swift
//  dbNoise
//
//  Created by Nick Sagan on 11.02.2022.
//

import Foundation

struct NoiseResult: Codable {
    let date: String
    let min: Int
    let avg: Int
    let max: Int
    let url: URL
}
