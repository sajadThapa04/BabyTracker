//
//  ContentView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
//            FeedingView()
//                .tabItem {
//                    Label("Feeding", systemImage: "drop.fill")
//                }
//            
//            DiaperView()
//                .tabItem {
//                    Label("Diapers", systemImage: "moon.fill")
//                }
            
            GrowthView()
                .tabItem {
                    Label("Growth", systemImage: "chart.xyaxis.line")
                }
               
            SettingsView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
