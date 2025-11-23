//
//  BabyTrackerApp.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI
import SwiftData

@main
struct BabyTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Install a SwiftData model container for your @Model types
        .modelContainer(for: [
            Baby.self,
            FeedingModel.self,
            Diaper.self,
            GrowthMeasurement.self
        ])
    }
}
