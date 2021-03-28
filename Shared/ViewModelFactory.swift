//
//  ViewModelFactory.swift
//  IntervalTimer
//
//  Created by Ostap on 28.03.2021.
//

import SwiftUI

final class ViewModelFactory {
    private let timerSettings: TimerSettings
    
    func makeTimerViewModel(showing: Binding<Bool>) -> TimerViewModel {
        return TimerViewModel(settings: timerSettings, showing: showing)
    }
    
    init(timerSettings: TimerSettings) {
        self.timerSettings = timerSettings
    }
}
