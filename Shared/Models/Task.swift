//
//  Task.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import Foundation

struct Task: Hashable, Codable, Identifiable {
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

extension Task.Interval: Codable {
    enum CodingKeys: CodingKey {
        case asBefore, setValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .asBefore:
                try container.encode(true, forKey: .asBefore)
            case .setValue(let interval):
                try container.encode(interval, forKey: .setValue)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        
        switch key {
        case .asBefore:
            self = .asBefore
        case .setValue:
            let interval = try container.decode(TimeInterval.self, forKey: .setValue)
            self = .setValue(interval)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}
