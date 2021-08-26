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
    @Binding var showing: Bool
    
    let timer: IntervalTimer
    var appeared = false
    var cycles = 0
    var timePassed = 0.0
    var lastUpdateTime = 0.0
    
    func startTimer() {
        timer.startCycle()
        lastUpdateTime = timer.lastUpdateTime
    }
    
    func recordHistory() {
        let policy = historyStore.currentPolicy
        if policy.record {
            historyStore.histories.append(.init(name: policy.name, cycles: cycles, duration: timePassed))
        }
    }
    
    // MARK: - Public
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
    
    init(settings: TimerSettings = .init(), historyStore: HistoryStore = .init(), showing: Binding<Bool>) {
        let adj: IntervalTimer.Frequency = (settings.interval - 1) / 1440
        self.timer = IntervalTimer(every: settings.interval, frequency: .default + adj)
        self.settings = settings
        self.historyStore = historyStore
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
                viewModel.startTimer()
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
