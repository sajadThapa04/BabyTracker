
//
//  FeedingModel.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import Foundation
import SwiftData

@Model
final class FeedingModel {
    
     var id: UUID = UUID()
    
    enum FeedingType: String, Codable, CaseIterable, Identifiable {
        case breast
        case bottle
        case pumped
        
        var id: String {self.rawValue}
        
    }
    
    enum BreastSide: String, Codable, CaseIterable, Identifiable {
        case left
        case right
        case both
        
        var id: String {self.rawValue}
        
    }
    
    var type: FeedingType
    var side: BreastSide?
    var amount: Double?
    var duration: Double?
    var timestamp: Date = Date()
    var notes: String?
    
    
     var baby: Baby?
    
    init(id: UUID, type: FeedingType, side: BreastSide? = nil, amount: Double? = nil, duration: Double? = nil, timestamp: Date, notes: String? = nil , baby: Baby? = nil) {
        self.id = id
        self.type = type
        self.side = side
        self.amount = amount
        self.duration = duration
        self.timestamp = timestamp
        self.notes = notes
        self.baby = baby
    }
}
