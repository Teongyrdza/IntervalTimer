//
//  IntervalTimer.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import Foundation
import Combine
import SwiftUI

final class IntervalTimer: ObservableObject {
    typealias Frequency = TimeInterval
    
    @Published var refreshTime: TimeInterval
    @Published var timeRemaining: TimeInterval
    
    var intervalPassed = PassthroughSubject<Void, Never>()
    var frequency: TimeInterval
    var lastUpdateTime = 0.0
    
    private var timer: Timer?
    private var newCycle = true
    
    private func ratio(now: TimeInterval) -> TimeInterval {
        if newCycle {
            newCycle = false
            return 1
        }
        else {
            let timePassed = now - lastUpdateTime
            return timePassed / frequency
        }
    }
    
    func startCycle() {
        timeRemaining = refreshTime
        lastUpdateTime = Date().timeIntervalSince1970
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [self] timer in
            if timeRemaining - frequency >= 0 {
                let now = Date().timeIntervalSince1970
                let ratio = ratio(now: now)
                lastUpdateTime = now
                timeRemaining -= ratio * frequency
            }
            else {
                timeRemaining = refreshTime
                newCycle = true
                intervalPassed.send()
            }
        }
    }
    
    func stopCycle() {
        timer?.invalidate()
        timer = nil
    }
    
    init(every interval: TimeInterval = 15, frequency: Frequency = .default) {
        refreshTime = interval
        timeRemaining = interval
        self.frequency = frequency
    }
    
    deinit {
        stopCycle()
    }
}

extension IntervalTimer.Frequency {
    static let `default`: Self = 1 / 60
}
