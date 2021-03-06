//
//  Task.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import Foundation
import Combine
import Reactor

struct Task: ObservableStruct, Hashable, Identifiable {
    static let `default` = Self(NSLocalizedString("Default", comment: ""), record: false)
    
    @Ignored var objectWillChange: PassthroughSubject<Void, Never> = .init()
    
    var id = UUID()
    @StructPublished var name: String
    @StructPublished var record: Bool
    @StructPublished var interval: TimeInterval?
    @StructPublished var recommendedDuration: TimeInterval?
    @StructPublished var nextTaskId: UUID?
    
    init(_ name: String, record: Bool, interval: TimeInterval? = nil) {
        self.name = name
        self.record = record
        self.interval = interval
        
        registerSubscriptions()
    }
}

extension Task: Codable {
    enum CodingKeys: CodingKey {
        case id, name, record, interval, recommendedDuration, nextTaskId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(record, forKey: .record)
        try container.encode(interval, forKey: .interval)
        try container.encode(recommendedDuration, forKey: .recommendedDuration)
        try container.encode(nextTaskId, forKey: .nextTaskId)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        record = try container.decode(Bool.self, forKey: .record)
        interval = try container.decodeIfPresent(TimeInterval.self, forKey: .interval)
        recommendedDuration = try container.decodeIfPresent(TimeInterval.self, forKey: .recommendedDuration)
        nextTaskId = try container.decodeIfPresent(UUID.self, forKey: .nextTaskId)
        
        registerSubscriptions()
    }
}
