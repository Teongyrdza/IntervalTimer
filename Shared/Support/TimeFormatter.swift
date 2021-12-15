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
        let formatString = NSLocalizedString("MinutesLabel", comment: "")
        return String.localizedStringWithFormat(formatString, minutes)
    }
    
    var minutesString: String {
        "\(minutes) \(minutesLabel)"
    }
    
    var seconds: Int {
        Int(self) % 60
    }
    
    var secondsLabel: String {
        let formatString = NSLocalizedString("SecondsLabel", comment: "")
        return String.localizedStringWithFormat(formatString, seconds)
    }
    
    var secondsString: String {
        "\(seconds) \(secondsLabel)"
    }
    
    func formatted() -> String {
        if minutes == 0 {
            return secondsString
        }
        else if seconds == 0 {
            return minutesString
        }
        else {
            return "\(minutesString) \(secondsString)"
        }
    }
}
