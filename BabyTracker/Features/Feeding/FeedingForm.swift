//
//  FeedingForm.swift
//  BabyTracker
//
//  Created by sajad kumar thapa on 24/11/2025.
//

import SwiftUI
import Combine

struct FeedingForm: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var viewModel = FeedingViewModel()
    
    private var primaryColor: Color {
        colorScheme == .dark ? .mint : .blue
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .black : Color(.systemGroupedBackground)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                Form {
                    FeedingTypeSection(viewModel: viewModel)
                    if viewModel.feedingType == .breast {
                        BreastSideSection(viewModel: viewModel)
                    }
                    if viewModel.feedingType == .bottle {
                        BottleAmountSection(viewModel: viewModel, primaryColor: primaryColor)
                    }
                    FeedingTimerSection(viewModel: viewModel, primaryColor: primaryColor, colorScheme: colorScheme)
                    NotesSection(viewModel: viewModel)
                    DateSection(viewModel: viewModel)
                }
                .scrollContentBackground(.hidden)
                .background(backgroundColor)
            }
            .navigationTitle("New Feeding")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.resetTimer()
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if viewModel.elapsedTime > 0 {
                            viewModel.duration = "\(Int(viewModel.elapsedTime / 60))"
                        }
                        viewModel.resetTimer()
                        dismiss()
                    }
                    .bold()
                    .foregroundColor(primaryColor)
                    .disabled(!viewModel.isFormValid)
                }
            }
            .onDisappear {
                viewModel.resetTimer()
            }
        }
        .accentColor(primaryColor)
    }
}

// MARK: - Feeding Type Section
struct FeedingTypeSection: View {
    @Bindable var viewModel: FeedingViewModel // USE @Bindable
    
    var body: some View {
        Section(header: SectionHeader(title: "Feeding Type", icon: "feeding", isSystemImage: false)) {
            Picker("Type", selection: $viewModel.feedingType) {
                ForEach(FeedingModel.FeedingType.allCases) { type in
                    Label(type.rawValue.capitalized, systemImage: viewModel.typeIcon(for: type))
                        .font(.title)
                    .tag(type)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color(.secondarySystemGroupedBackground))
        }
    }
}

// MARK: - Breast Side Section
struct BreastSideSection: View {
    @Bindable var viewModel: FeedingViewModel // USE @Bindable
    
    var body: some View {
        Section(header: SectionHeader(title: "Breast Side", icon: "heart.fill")) {
            Picker("Side", selection: $viewModel.breastSide) {
                ForEach(FeedingModel.BreastSide.allCases) { side in
                    Label(side.rawValue.capitalized, systemImage: viewModel.breastIcon(for: side))
                     
                    .tag(side)
                }
            }
            .pickerStyle(.segmented)
            .listRowBackground(Color(.secondarySystemGroupedBackground))
        }
    }
}

// MARK: - Bottle Amount Section
struct BottleAmountSection: View {
    @Bindable var viewModel: FeedingViewModel // USE @Bindable
    var primaryColor: Color
    
    var body: some View {
        Section(header: SectionHeader(title: "Bottle Amount", icon: "waterbottle.fill")) {
            HStack {
                Image(systemName: "bottle.fill")
                    .foregroundColor(primaryColor)
                    .font(.title3)
                TextField("Enter amount in ml", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                    .font(.body)
                Text("ml")
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 4)
        }
    }
}

// MARK: - Timer Section
struct FeedingTimerSection: View {
    @Bindable var viewModel: FeedingViewModel
    var primaryColor: Color
    var colorScheme: ColorScheme
    
    var body: some View {
        Section(header: SectionHeader(title: "Duration", icon: "clock.circle")) {
            VStack(spacing: 20) {
                
                // Timer Display
                if viewModel.isTimerRunning || viewModel.elapsedTime >= 0 {
                    HStack {
                        Spacer()
                        VStack(spacing: 8) {
                            Text(viewModel.formatTime(viewModel.elapsedTime))
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .monospacedDigit()
                                .foregroundColor(primaryColor)
                                .scaleEffect(viewModel.isTimerRunning ? 1.05 : 1.0)
                                .animation(.interactiveSpring(duration: 0.1).repeatForever(autoreverses: true), value: viewModel.isTimerRunning)
                                .id("timer-\(viewModel.elapsedTime)")
                            Text("Duration")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .transition(.opacity)
                    .padding(.vertical, 8)
                }
                
                // Timer Buttons
                HStack(spacing: 12) {
                    if viewModel.isTimerRunning {
                        // Stop Button
                        TimerButton(
                            title: "Stop",
                            icon: "stop.circle.fill",
                            color: .white,
                            gradient: stopButtonGradient,
                            action: {
                                viewModel.stopTimer()
                            }
                        )
                    } else if viewModel.elapsedTime > 0 {
                        // Resume Button
                        TimerButton(
                            title: "Resume",
                            icon: "play.circle.fill",
                            color: .white,
                            gradient: resumeButtonGradient,
                            action: {
                                viewModel.startTimer()
                            }
                        )
                    } else {
                        // Start Button
                        TimerButton(
                            title: "Start Timer",
                            icon: "play.circle.fill",
                            color: .white,
                            gradient: startButtonGradient,
                            action: {
                                viewModel.startTimer()
                            }
                        )
                    }
                    
                    // Reset Button - Only show when timer has been used
                    if viewModel.elapsedTime > 0 || viewModel.isTimerRunning {
                        TimerButton(
                            title: "Reset",
                            icon: "arrow.clockwise.circle.fill",
                            color: .white,
                            gradient: resetButtonGradient,
                            action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.resetTimer()
                                }
                            }
                        )
                    }
                }
                .frame(height: 50)
                
                // Manual input fallback
                ManualDurationInput(duration: $viewModel.duration)
            }
            .padding(.vertical, 12)
        }
    }
    
    // Professional gradient properties
    private var startButtonGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.1, green: 0.7, blue: 0.5),   // Deep teal
                Color(red: 0.2, green: 0.8, blue: 0.6),   // Bright teal
                Color(red: 0.3, green: 0.9, blue: 0.7)    // Light teal
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var stopButtonGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.8, green: 0.2, blue: 0.2),   // Deep red
                Color(red: 0.9, green: 0.3, blue: 0.3),   // Medium red
                Color(red: 1.0, green: 0.4, blue: 0.4)    // Light red
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var resumeButtonGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.2, green: 0.4, blue: 0.8),   // Deep blue
                Color(red: 0.3, green: 0.5, blue: 0.9),   // Medium blue
                Color(red: 0.4, green: 0.6, blue: 1.0)    // Light blue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    private var resetButtonGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(red: 0.4, green: 0.4, blue: 0.4),   // Charcoal gray
                Color(red: 0.5, green: 0.5, blue: 0.5),   // Medium gray
                Color(red: 0.6, green: 0.6, blue: 0.6)    // Light gray
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: - Timer Button
struct TimerButton: View {
    var title: String
    var icon: String
    var color: Color
    var gradient: LinearGradient
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                Text(title)
                    .font(.system(size: 14, weight: .medium))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 8)
            .foregroundColor(color)
        }
        .background(gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .buttonStyle(BorderlessButtonStyle())
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}
// MARK: - Manual Duration Input
struct ManualDurationInput: View {
    @Binding var duration: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "keyboard")
                .foregroundColor(.secondary)
            Text("Enter manually:")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            TextField("Minutes", text: $duration)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .frame(width: 80)
                .padding(8)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                .focused($isTextFieldFocused)
                .onTapGesture {
                    isTextFieldFocused = true
                }
            
            Text("min")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            // This prevents taps on the row from going through
        }
    }
}
// MARK: - Notes Section
struct NotesSection: View {
    @Bindable var viewModel: FeedingViewModel // USE @Bindable
    
    var body: some View {
        Section(header: SectionHeader(title: "Notes", icon: "note.text")) {
            VStack(alignment: .leading) {
                TextEditor(text: $viewModel.notes)
                    .frame(minHeight: 80)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    .padding(.top, 8)
                
                if viewModel.notes.isEmpty {
                    Text("Any additional notes about this feeding session...")
                        .foregroundColor(.secondary)
                        .font(.caption)
                        .padding(.top, 8)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Date Section
struct DateSection: View {
    @Bindable var viewModel: FeedingViewModel // USE @Bindable
    
    var body: some View {
        Section(header: SectionHeader(title: "Date & Time", icon: "calendar")) {
            DatePicker("Feeding Time", selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
        }
    }
}

// MARK: - SectionHeader
struct SectionHeader: View {
    let title: String
    let icon: String
    var isSystemImage: Bool = true
    private let iconSize: CGFloat = 24
    
    var body: some View {
        HStack {
            if isSystemImage {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(.cyan)
            } else {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
            }
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    FeedingForm()
}
