//
//  HistoryPolicy.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import Foundation

/// A policy that describes how history will be recorded
struct HistoryPolicy: Hashable, Codable, Identifiable {
    static let `default` = Self("Default", record: false)
    
    var id = UUID()
    var name: String
    var record: Bool
    
    init(_ name: String, record: Bool) {
        self.name = name
        self.record = record
    }
}
