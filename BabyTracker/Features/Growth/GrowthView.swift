
//
//  GrowthView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct GrowthView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // MARK: - Add Measurement Button
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("Add Measurement")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.18))
                    .foregroundColor(.purple)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                
                
                // MARK: - Summary Cards
                VStack(spacing: 16) {
                    
                    HStack(spacing: 16) {
                        GrowthCard(
                            icon: "scalemass",
                            title: "Weight",
                            value: "--"
                        )
                        
                        GrowthCard(
                            icon: "arrow.up.and.down",
                            title: "Height",
                            value: "--"
                        )
                    }
                    
                    GrowthCard(
                        icon: "circle.circle",
                        title: "Head Size",
                        value: "--"
                    )
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                
                // MARK: - Chart / Empty State
                VStack(spacing: 12) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 40))
                        .foregroundColor(.purple.opacity(0.7))
                    
                    Text("No measurements yet")
                        .font(.headline)
                    
                    Text("Add your baby’s measurements to see growth charts and percentiles.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 40)
                
                Spacer()
            }
            .navigationTitle("Growth")
        }
    }
}


// MARK: - Growth Card Component
struct GrowthCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.purple.opacity(0.8))
                .clipShape(Circle())
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}


#Preview {
    GrowthView()
}
