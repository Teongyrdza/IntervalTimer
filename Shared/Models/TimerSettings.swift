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
    @Published var currentTaskId = Task.default.id
    
    var currentTaskInterval: Task.Interval = .asBefore {
        didSet {
            if case let .setValue(newInterval) = currentTaskInterval {
                interval = newInterval
            }
        }
    }
}
