
//
//  HomeView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct HomeView: View {
    @State private var showingForm = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Greeting
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome Back!")
                            .font(.title).bold()
                        Text("Here’s what’s going on today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    
                    // MARK: - Today Summary Cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            
                            SummaryCard(
                                iconName: "feeding", // your PDF asset for feeding
                                title: "Feedings",
                                value: "0"
                            )
                            
                            SummaryCard(
                                iconName: "diaper", // your PDF asset for diaper
                                title: "Diapers",
                                value: "0"
                            )
                            
                            SummaryCard(
                                iconName: "bed.double.fill", // still SF Symbol
                                title: "Sleep",
                                value: "--"
                            )
                            
                        }
                    }
                    .padding(.horizontal)

                    
                    // MARK: - Quick Actions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 16) {
                            // Navigate to FeedingView
                            // MARK: - Add Feeding Button
                            Button(action: {
                                showingForm = true
                            })
                            {
                                QuickActionButton(
                                    title: "Add Feeding",
                                    icon: "plus.circle.fill",
                                    color: .blue
                                )

                            }
                            .sheet(isPresented: $showingForm) {
                                FeedingForm()
                            }
                                
                
                            
                            // Navigate to DiaperView
                            NavigationLink {
                                DiaperView()
                            } label: {
                                QuickActionButton(
                                    title: "Add Diaper",
                                    icon: "plus.circle.fill",
                                    color: .green
                                )
                            }
                        }
                        .padding(.horizontal)
                    }

                    Spacer()
                }
            }
            .navigationTitle("Menor")
        }
    }
}


// MARK: - Summary Card Component
struct SummaryCard: View {
    let iconName: String
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 8) {

            // Check if iconName is PDF asset or SF Symbol
            if UIImage(named: iconName) != nil {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(12)
                    .background(Color.blue.opacity(0.8))
                    .clipShape(Circle())
            } else {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.blue.opacity(0.8))
                    .clipShape(Circle())
            }

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.headline)
                .bold()
        }
        .frame(width: 100)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}



// MARK: - Quick Action Button
struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(title)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(color.opacity(0.15))
        .foregroundColor(color)
        .cornerRadius(14)
    }
}



#Preview {
    HomeView()
}
