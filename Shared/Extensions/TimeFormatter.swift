//
//  TimeFormatter.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import Foundation

extension TimeInterval {
    var seconds: Int {
        Int(self) % 60
    }
    
    var secondsMetric: String {
        seconds == 1 ? "second" : "seconds"
    }
    
    var minutes: Int {
        Int(self) / 60
    }
    
    var minutesMetric: String {
        minutes == 1 ? "minute" : "minutes"
    }
    
    func formatted() -> String {
        if self < 60 {
            return "\(seconds) \(secondsMetric)"
        }
        else if seconds == 0 {
            return "\(minutes) \(minutesMetric)"
        }
        else {
            return "\(minutes) \(minutesMetric) \(seconds) \(secondsMetric)"
        }
    }
}
