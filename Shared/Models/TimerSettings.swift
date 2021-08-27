//
//  TimerSettings.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import AVFoundation
import Foundation
import Combine

final class TimerSettings: ObservableObject {
    @Published var interval: TimeInterval = 30
    @Published var sound = sounds[1]
    @Published var currentTask = Task.default {
        didSet {
            if case let .setValue(newInterval) = currentTask.interval {
                interval = newInterval
            }
        }
    }
}
