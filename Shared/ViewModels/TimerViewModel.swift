//
//  TimerViewModel.swift
//  IntervalTimer
//
//  Created by Ostap on 28.03.2021.
//

import SwiftUI
import AVFoundation
import Combine

final class TimerViewModel {
    @StateObject private var timer: IntervalTimer
    @ObservedObject private var settings: TimerSettings
    @Binding private var showing: Bool
    
    private var secondsRemaining: Int {
        Int(timer.timeRemaining) % 60
    }
    
    private var secondsRemainingMetric: String {
        secondsRemaining == 1 ? "second" : "seconds"
    }
    
    private var minutesRemaining: Int {
        Int(timer.timeRemaining) / 60
    }
    
    private var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    
    var player: AVPlayer { settings.sound.player }
    var timeRemaining: CGFloat { CGFloat(timer.timeRemaining / timer.refreshTime) }
    var alarmText: String {
        if timer.timeRemaining < 60 {
            return "Alarm in \(secondsRemaining) \(secondsRemainingMetric)"
        }
        else {
            return "Alarm in \(minutesRemaining) \(minutesRemainingMetric) \(secondsRemaining) \(secondsRemainingMetric)"
        }
    }
    
    init(every interval: TimeInterval, settings: TimerSettings, showing: Binding<Bool>) {
        self._timer = StateObject(wrappedValue: IntervalTimer(every: interval))
        self.settings = settings
        self._showing = showing
    }
}
