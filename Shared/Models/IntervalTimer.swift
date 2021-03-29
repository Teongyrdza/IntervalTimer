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
    @Published var refreshTime: TimeInterval
    @Published var timeRemaining: TimeInterval
    @Published var isRunning = false
    
    var intervalPassed = PassthroughSubject<Void, Never>()
    
    private var timeInterval: Timer?
    private var refreshInterval: Timer?
    
    func startCycle() {
        timeRemaining = refreshTime
        timeInterval = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        
        refreshInterval = Timer.scheduledTimer(withTimeInterval: refreshTime, repeats: true) { [unowned self] timer in
            timeRemaining = refreshTime
            intervalPassed.send()
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
    
    init(every interval: TimeInterval) {
        refreshTime = interval
        timeRemaining = interval
    }
    
    deinit {
        stopCycle()
    }
}
