import Foundation
import Observation

@Observable
class FeedingViewModel {
    var feedingType: FeedingModel.FeedingType = .breast
    var breastSide: FeedingModel.BreastSide = .left
    var amount: String = ""
    var duration: String = ""
    var notes: String = ""
    var date: Date = Date()
    
    // Timer state
    var isTimerRunning = false
    var elapsedTime: TimeInterval = 0
    
    private var timerStartTime: Date?
    private var accumulatedTime: TimeInterval = 0 // Track accumulated time when paused
    private var timer: Timer?
    
    func toggleTimer() {
        isTimerRunning ? stopTimer() : startTimer()
    }
    
    func startTimer() {
        guard !isTimerRunning else { return }
        
        isTimerRunning = true
        
        // If we have accumulated time, calculate when we should have started
        // to achieve the total elapsed time
        if accumulatedTime > 0 {
            // The timer should start from a date that's "accumulatedTime" seconds ago
            timerStartTime = Date().addingTimeInterval(-accumulatedTime)
        } else {
            // Starting fresh
            timerStartTime = Date()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let startTime = self.timerStartTime else { return }
            self.elapsedTime = Date().timeIntervalSince(startTime)
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        
        
        // Store the elapsed time so we can resume from it
        accumulatedTime = elapsedTime
    }
    
    func resetTimer() {
        stopTimer()
        elapsedTime = 0
        accumulatedTime = 0
        timerStartTime = nil
    }
    
    var isFormValid: Bool {
        if feedingType == .bottle {
            return !amount.isEmpty && (!duration.isEmpty || elapsedTime > 0)
        }
        return !duration.isEmpty && elapsedTime > 0
    }
    
    func formatTime(_ sec: TimeInterval) -> String {
        let m = Int(sec) / 60
        let s = Int(sec) % 60
        return String(format:"%02d:%02d", m, s)
    }
    
    func typeIcon(for type: FeedingModel.FeedingType) -> String {
        switch type {
        case .breast:
            return "figure.arms.open"
        case .bottle:
            return "waterbottle.fill"
        case .pumped:
            return "drop.fill"
        @unknown default:
            return "questionmark.circle"
        }
    }

    func breastIcon(for side: FeedingModel.BreastSide) -> String {
        switch side {
        case .left:
            return "l.circle.fill"
        case .right:
            return "r.circle.fill"
        case .both:
            return "arrow.left.arrow.right.circle.fill"
        @unknown default:
            return "questionmark.circle"
        }
    }
}
