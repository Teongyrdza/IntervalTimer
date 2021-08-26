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
    
    func makeTimerViewModel(showing: Binding<Bool>) -> TimerViewModel {
        return TimerViewModel(settings: timerSettings, historyStore: historyStore, showing: showing)
    }
    
    init(timerSettings: TimerSettings, historyStore: HistoryStore = .init()) {
        self.timerSettings = timerSettings
        self.historyStore = historyStore
    }
}
