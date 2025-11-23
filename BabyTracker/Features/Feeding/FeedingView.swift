
//
//  FeedingView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct FeedingView: View {
    @State private var showingForm = false
    // You can also create a @StateObject here if you want to share the same view model instance
    // @StateObject private var viewModel = FeedingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Add Feeding Button
                Button{
                    showingForm.toggle()
                }
                label:{
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("Add Feeding")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.15))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                .sheet(isPresented: $showingForm) {
                    FeedingForm()
                }
                
                // MARK: - History / Empty State
                VStack(spacing: 12) {
                    Image("feeding")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(12)
                        .background(Color.blue.opacity(0.8))
                        .clipShape(Circle())
                    
                    Text("No feedings logged yet")
                        .font(.headline)
                    
                    Text("Tap the button above to record your baby's first feeding.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
                .padding(.top, 50)
                
                Spacer()
            }
            .navigationTitle("Feeding")
        }
    }
}

#Preview {
    FeedingView()
}
