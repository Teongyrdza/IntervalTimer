//
//  TimerViewModel.swift
//  IntervalTimer
//
//  Created by Ostap on 28.03.2021.
//

import SwiftUI
import AVFoundation
import Combine

final class TimerViewModel: ObservableObject {
    // MARK: - Private
    var timer: IntervalTimer
    @ObservedObject var settings: TimerSettings
    @Binding var showing: Bool
    
    var secondsRemaining: Int {
        Int(timer.timeRemaining) % 60
    }
    
    var secondsRemainingMetric: String {
        secondsRemaining == 1 ? "second" : "seconds"
    }
    
    var minutesRemaining: Int {
        Int(timer.timeRemaining) / 60
    }
    
    var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    
    // MARK: - Public
    @Published var state: State {
        willSet {
            print("TimerViewModel exiting \(state) state")
            state.exit(self)
        }
        didSet {
            print("TimerViewModel entering \(state) state")
            state.enter(self)
        }
    }
    
    var timeRemaining: CGFloat { CGFloat(timer.timeRemaining / timer.refreshTime) }
    var alarmText: String {
        if timer.timeRemaining < 60 {
            return "Alarm in \(secondsRemaining) \(secondsRemainingMetric)"
        }
        else {
            return "Alarm in \(minutesRemaining) \(minutesRemainingMetric) \(secondsRemaining) \(secondsRemainingMetric)"
        }
    }
    
    init(settings: TimerSettings, showing: Binding<Bool>) {
        self.timer = IntervalTimer(every: settings.interval)
        self.settings = settings
        self._showing = showing
        self.state = .hidden
        
        self.timer.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        
        self.timer.intervalPassed.sink {
            settings.sound.player.seek(to: .zero)
            settings.sound.player.play()
        }
    }
}

// MARK: - State
extension TimerViewModel {
    class State: CustomStringConvertible {
        var description: String { "state" }
        
        func enter(_ viewModel: TimerViewModel) {}
        func exit(_ viewModel: TimerViewModel) {}
        
        static let running = Running()
        static let stopped = Stopped()
        static let hidden = Hidden()
        
        class Running: State {
            override var description: String { "running" }
            
            override func enter(_ viewModel: TimerViewModel) {
                viewModel.timer.startCycle()
            }
            
            override func exit(_ viewModel: TimerViewModel) {
                viewModel.timer.stopCycle()
            }
        }
        
        class Stopped: State {
            override var description: String { "stopped" }
        }
        
        class Hidden: State {
            override var description: String { "hidden" }
            
            override func enter(_ viewModel: TimerViewModel) {
                viewModel.showing = false
            }
            
            override func exit(_ viewModel: TimerViewModel) {
                viewModel.showing = true
            }
        }
    }
}

extension TimerViewModel.State: Equatable {
    static func == (lhs: TimerViewModel.State, rhs: TimerViewModel.State) -> Bool {
        type(of: lhs) == type(of: rhs)
    }
}
