//
//  TimerSettings.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import AVFoundation
import Foundation
import Combine

final class TimerSettings: ObservableObject, Codable, DefaultConstructible {
    static let intervalRange = 1..<181
    
    @Published var interval: TimeInterval = 30
    @Published var sound = sounds[1]
    @Published var currentTaskId = Task.default.id {
        didSet {
            if let newInterval = currentTask?.interval {
                interval = newInterval
            }
        }
    }
    
    var currentTask: Task? {
        taskStore?.task(for: currentTaskId)
    }
    
    var taskStore: TaskStore?
    
    enum CodingKeys: CodingKey {
        case interval, sound, currentTaskId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interval, forKey: .interval)
        try container.encode(sound, forKey: .sound)
        try container.encode(currentTaskId, forKey: .currentTaskId)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        interval = try container.decode(TimeInterval.self, forKey: .interval)
        sound = try container.decode(Sound.self, forKey: .sound)
        currentTaskId = try container.decode(UUID.self, forKey: .currentTaskId)
    }
    
    init() {}
}

extension TimerSettings {
    private static let url = DataStore.settingsURL
    
    static func load() -> Self {
        DataStore.load(self, from: url)
    }
    
    func save() {
        DataStore.save(self, to: Self.url)
    }
}
