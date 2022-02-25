//
//  IDFabric.swift
//  dbNoise
//
//  Created by Nick Sagan on 25.02.2022.
//

import Foundation

class IDFabric {
    
    static let shared = IDFabric()
    private init() { }
    
    private var id: Int {
        get {
            UserDefaults.standard.integer(forKey: "uniqueID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "uniqueID")
        }
    }
    
    func getID() -> Int {
        id += 1
        return id
    }
}
