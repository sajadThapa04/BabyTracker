
//
//  Diaper.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import Foundation
import SwiftData

@Model
final class Diaper {
    
    // MARK: - Properties
    var id: UUID = UUID()
    
    enum DiaperType: String, Codable, CaseIterable, Identifiable {
        case wet
        case dirty
        case both
        
        var id: String { rawValue }
    }
    
    var type: DiaperType
    var timestamp: Date = Date()
    var notes: String?
    var baby: Baby?
    
    // MARK: - Initializer
    init(type: DiaperType,
         timestamp: Date = Date(),
         notes: String? = nil,
         baby: Baby? = nil) {
        self.type = type
        self.timestamp = timestamp
        self.notes = notes
        self.baby = baby
    }
}
