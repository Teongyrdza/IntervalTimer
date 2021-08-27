//
//  Task.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import Foundation

struct Task: Hashable, Identifiable {
    static let `default` = Self("Default", record: false)
    
    var id = UUID()
    var name: String
    var record: Bool
    var interval: Interval
    
    enum Interval: Hashable {
        case asBefore
        case setValue(TimeInterval)
    }
    
    init(_ name: String, record: Bool, interval: Interval = .asBefore) {
        self.name = name
        self.record = record
        self.interval = interval
    }
}
