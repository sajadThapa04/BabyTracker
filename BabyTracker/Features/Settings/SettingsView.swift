
//
//  SettingsView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                
                // MARK: - Baby Profile
                Section(header: Text("Baby Profile")) {
                    NavigationLink(destination: Text("Edit Baby Profile")) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            Text("Baby Info")
                        }
                    }
                }
                
                
                // MARK: - App Settings
                Section(header: Text("App Settings")) {
                    NavigationLink(destination: Text("Theme Settings")) {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                                .foregroundColor(.purple)
                            Text("Appearance")
                        }
                    }
                    
                    NavigationLink(destination: Text("Reminder Settings")) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.orange)
                            Text("Reminders")
                        }
                    }
                }
                
                
                // MARK: - Data
                Section(header: Text("Data")) {
                    NavigationLink(destination: Text("Export Logs")) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.green)
                            Text("Export Data")
                        }
                    }
                }
                
                
                // MARK: - About
                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Privacy Policy")) {
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.red)
                            Text("Privacy Policy")
                        }
                    }
                    
                    NavigationLink(destination: Text("About the App")) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("About")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
