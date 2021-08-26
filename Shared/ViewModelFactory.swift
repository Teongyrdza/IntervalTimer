//
//  ViewModelFactory.swift
//  IntervalTimer
//
//  Created by Ostap on 28.03.2021.
//

import SwiftUI

final class ViewModelFactory {
    private let timerSettings: TimerSettings
    private let historyStore: HistoryStore
    private let taskStore: TaskStore
    
    func makeTimerViewModel(showing: Binding<Bool>) -> TimerViewModel {
        return TimerViewModel(settings: timerSettings, historyStore: historyStore, taskStore: taskStore, showing: showing)
    }
    
    init(timerSettings: TimerSettings, historyStore: HistoryStore = .init(), taskStore: TaskStore = .init()) {
        self.timerSettings = timerSettings
        self.historyStore = historyStore
        self.taskStore = taskStore
    }
}
