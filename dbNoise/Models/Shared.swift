//
//  Shared.swift
//  dbNoise
//
//  Created by Nick Sagan on 04.02.2022.
//

import Foundation

class Shared {
    static let instance = Shared()
    private init() { }
    var results: [Result] {
        get {
            guard let data = try? Data(contentsOf: .resultsArray) else { return [] }
            return (try? JSONDecoder().decode([Result].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .resultsArray)
        }
    }
}
