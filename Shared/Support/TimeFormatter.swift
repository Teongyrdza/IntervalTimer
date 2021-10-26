//
//  TimeFormatter.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import Foundation

extension TimeInterval {
    var minutes: Int {
        Int(self) / 60
    }
    
    var minutesLabel: String {
        let formatString = NSLocalizedString("MinuteCount", comment: "")
        return String.localizedStringWithFormat(formatString, minutes)
    }
    
    var seconds: Int {
        Int(self) % 60
    }
    
    var secondsLabel: String {
        let formatString = NSLocalizedString("SecondCount", comment: "")
        return String.localizedStringWithFormat(formatString, seconds)
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
