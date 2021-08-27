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
    private var cancellables = Set<AnyCancellable>()
    
    let settings: TimerSettings
    let historyStore: HistoryStore
    let taskStore: TaskStore
    
    @Binding var showing: Bool
    
    let timer: IntervalTimer
    var appeared = false
    var cycles = 0
    var timePassed = 0.0
    var lastUpdateTime = 0.0
    var paused = false
    
    func startTimer() {
        timer.startCycle()
        lastUpdateTime = timer.lastUpdateTime
    }
    
    func recordHistory() {
        let task = settings.currentTask
        if task.record {
            historyStore.histories.append(.init(name: task.name, cycles: cycles, duration: timePassed))
        }
    }
    
    // MARK: - View properties
    @Published var state: State {
        willSet {
            if newValue != state {
                state.exit(self)
            }
        }
        didSet {
            if state != oldValue {
                state.enter(self)
            }
        }
    }
    
    var timeRemaining: CGFloat { CGFloat(timer.timeRemaining / timer.refreshTime) }
    var alarmText: String {
        "Alarm in \(timer.timeRemaining.formatted())"
    }
    
    var leftButtonColor = Color.accentColor
    var leftButtonText = ""
    
    // MARK: - Event handlers
    func leftButtonTapped() {
        state = paused ? .running : .stopped
    }
    
    func rightButtonTapped() {
        state = .hidden
    }
    
    init(settings: TimerSettings = .init(), historyStore: HistoryStore = .init(), taskStore: TaskStore = .init(), showing: Binding<Bool>) {
        let adj: IntervalTimer.Frequency = (settings.interval - 1) / 1440
        self.timer = IntervalTimer(every: settings.interval, frequency: .default + adj)
        self.settings = settings
        self.historyStore = historyStore
        self.taskStore = taskStore
        self._showing = showing
        self.state = .hidden
        
        timer.objectWillChange
            .sink { [self] _ in
                objectWillChange.send()
                timePassed += timer.lastUpdateTime - lastUpdateTime
                lastUpdateTime = timer.lastUpdateTime
            }
            .store(in: &cancellables)
        
        timer.intervalPassed
            .sink { [self] in
                cycles += 1
                settings.sound.player.seek(to: .zero)
                settings.sound.player.play()
            }
            .store(in: &cancellables)
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
                viewModel.leftButtonColor = .init("AccentColor")
                viewModel.leftButtonText = "Pause"
                
                viewModel.startTimer()
            }
            
            override func exit(_ viewModel: TimerViewModel) {
                viewModel.timer.stopCycle()
            }
        }
        
        class Stopped: State {
            override var description: String { "stopped" }
            
            override func enter(_ viewModel: TimerViewModel) {
                viewModel.leftButtonColor = .green
                viewModel.leftButtonText = "Resume"
                
                viewModel.paused = true
            }
            
            override func exit(_ viewModel: TimerViewModel) {
                viewModel.paused = false
            }
        }
        
        class Hidden: State {
            override var description: String { "hidden" }
            
            override func enter(_ viewModel: TimerViewModel) {
                if viewModel.appeared {
                    viewModel.recordHistory()
                }
                viewModel.showing = false
            }
            
            override func exit(_ viewModel: TimerViewModel) {
                viewModel.showing = true
                viewModel.appeared = true
            }
        }
    }
}

extension TimerViewModel.State: Equatable {
    static func == (lhs: TimerViewModel.State, rhs: TimerViewModel.State) -> Bool {
        type(of: lhs) == type(of: rhs)
    }
}
