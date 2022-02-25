//
//  Shared.swift
//  dbNoise
//
//  Created by Nick Sagan on 04.02.2022.
//

import Foundation

// https://stackoverflow.com/questions/63367953/storing-array-of-custom-objects-in-userdefaults


class Shared {
    static let instance = Shared()
    
    private init() { }
    
    var hearingResults: [HearingResult] {
        get {
            guard let data = try? Data(contentsOf: .hearingResults) else { return [] }
            return (try? JSONDecoder().decode([HearingResult].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .hearingResults)
        }
    }
    
    var noiseResults: [NoiseResult] {
        get {
            guard let data = try? Data(contentsOf: .noiseResults) else { return [] }
            return (try? JSONDecoder().decode([NoiseResult].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .noiseResults)
        }
    }
}

// To save and read [HearingResult] & [NoiseResult]
// https://stackoverflow.com/questions/63367953/storing-array-of-custom-objects-in-userdefaults

extension URL {
    static var hearingResults: URL {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "dBNoise"
        let subDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        try? FileManager.default.createDirectory(at: subDirectory, withIntermediateDirectories: true, attributes: nil)
        return subDirectory.appendingPathComponent("results.json")
    }
    
    static var noiseResults: URL {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "dBNoise"
        let subDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        try? FileManager.default.createDirectory(at: subDirectory, withIntermediateDirectories: true, attributes: nil)
        return subDirectory.appendingPathComponent("noiseResults.json")
    }
}
