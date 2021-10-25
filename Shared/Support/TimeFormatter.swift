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
    
    var secondsLabel: String {
        seconds == 1 ? "1 second" : "\(seconds) seconds"
    }
    
    var minutes: Int {
        Int(self) / 60
    }
    
    var minutesLabel: String {
        minutes == 1 ? "1 minute" : "\(minutes) minutes"
    }
    
    func formatted() -> String {
        if minutes == 0 {
            return secondsLabel
        }
        else if seconds == 0 {
            return minutesLabel
        }
        else {
            return "\(minutesLabel) \(secondsLabel)"
        }
    }
}
