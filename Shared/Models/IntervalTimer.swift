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
    @Published var isRunning = false
    
    var intervalPassed = PassthroughSubject<Void, Never>()
    let frequency: TimeInterval
    
    private var timer: Timer?
    private var lastUpdateTime: TimeInterval?
    
    private func updateTime(and ratio: inout Double) {
        let now = Date().timeIntervalSince1970
        
        if lastUpdateTime == nil {
            ratio = 1
        }
        else {
            let timePassed = now - lastUpdateTime!
            ratio = timePassed / frequency
        }
        
        lastUpdateTime = now
    }
    
    func startCycle() {
        timeRemaining = refreshTime
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [unowned self] timer in
            if timeRemaining - frequency >= 0 {
                var ratio = 1.0
                updateTime(and: &ratio)
                timeRemaining -= ratio * frequency
            }
            else {
                timeRemaining = refreshTime
                lastUpdateTime = nil
                intervalPassed.send()
            }
        }
        
        isRunning = true
    }
    
    func stopCycle() {
        timer?.invalidate()
        timer = nil
        
        isRunning = false
    }
    
    init(every interval: TimeInterval, frequency: Frequency) {
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
