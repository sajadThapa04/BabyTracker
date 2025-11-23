
//
//  DiaperView.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 23/11/2025.
//

import SwiftUI

struct DiaperView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Add Diaper Button
                Button(action: {}) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                        Text("Add Diaper Change")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.18))
                    .foregroundColor(.green)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top, 16)
                }
                
                
                // MARK: - Empty State
                if true {  // Later becomes `diaperLogs.isEmpty`
                    VStack(spacing: 12) {
                        Image("diaper")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .padding(12)
                            .background(Color.green.opacity(0.7))
                            .clipShape(Circle())
                        Text("No diaper logs yet")
                            .font(.headline)
                        
                        Text("Tap the button above to record your baby's diaper change.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .padding(.top, 50)
                } else {
                    // Future: List of diapers
                }
                
                Spacer()
            }
            .navigationTitle("Diapers")
        }
    }
}

#Preview {
    DiaperView()
}
