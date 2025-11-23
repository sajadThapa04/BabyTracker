
import Foundation
import SwiftData

@Model
final class Baby {
    
    // MARK: - Properties
    var id: UUID = UUID()
    var name: String
    var nickname: String?
    var gender: String
    var birthDate: Date
    
    // Optional starting stats
    var birthWeight: Double?   // kg
    var birthHeight: Double?   // cm
    var birthHeadSize: Double? // cm
    
    var weightUnit: String = "kg"
    var heightUnit: String = "cm"
    var profilePhoto: Data?
    var notes: String?
    var timeZone: String = TimeZone.current.identifier
    
    
    // Relationship: one baby → many feedings (CASCADE delete)
       @Relationship(deleteRule: .cascade, inverse: \FeedingModel.baby)
       var feedings: [FeedingModel] = []

       // Relationship: one baby → many diapers (CASCADE delete)
       @Relationship(deleteRule: .cascade, inverse: \Diaper.baby)
       var diapers: [Diaper] = []

       // Relationship: one baby → many growth measurements (CASCADE delete)
       @Relationship(deleteRule: .cascade, inverse: \GrowthMeasurement.baby)
       var growthMeasurements: [GrowthMeasurement] = [] // Fixed typo: was growthMeasurement
       
    
    // MARK: - Initializer
    init(name: String,
         nickname: String? = nil,
         gender: String,
         birthDate: Date,
         birthWeight: Double? = nil,
         birthHeight: Double? = nil,
         birthHeadSize: Double? = nil,
         profilePhoto: Data? = nil,
         notes: String? = nil) {
        
        self.name = name
        self.nickname = nickname
        self.gender = gender
        self.birthDate = birthDate
        self.birthWeight = birthWeight
        self.birthHeight = birthHeight
        self.birthHeadSize = birthHeadSize
        self.profilePhoto = profilePhoto
        self.notes = notes
    }
}
