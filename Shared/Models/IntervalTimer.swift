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
    
    private var timeInterval: Timer?
    private var refreshInterval: Timer?
    
    func startCycle() {
        timeRemaining = refreshTime
        timeInterval = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [unowned self] timer in
            if timeRemaining - frequency >= 0 {
                timeRemaining -= frequency
            }
            else {
                timeRemaining = refreshTime
                intervalPassed.send()
            }
        }
        
        isRunning = true
    }
    
    func stopCycle() {
        timeInterval?.invalidate()
        refreshInterval?.invalidate()
        timeInterval = nil
        refreshInterval = nil
        
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
