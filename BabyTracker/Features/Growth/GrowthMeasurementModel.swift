
//
//  GrowthMeasurement.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import Foundation
import SwiftData

@Model
final class GrowthMeasurement {
    
    // MARK: - Properties
    var id: UUID = UUID()
    var weight: Double?       // in kg
    var height: Double?       // in cm
    var headSize: Double?     // in cm
    var timestamp: Date = Date()
    var notes: String?
    var baby: Baby?
 
    // MARK: - Initializer
    init(weight: Double? = nil,
         height: Double? = nil,
         headSize: Double? = nil,
         timestamp: Date = Date(),
         notes: String? = nil,
         baby: Baby? = nil) {
        
        self.weight = weight
        self.height = height
        self.headSize = headSize
        self.timestamp = timestamp
        self.notes = notes
        self.baby = baby
    }
}
