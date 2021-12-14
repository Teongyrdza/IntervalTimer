//
//  TimerSettings.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import AVFoundation
import Foundation
import Combine
import SoundKit
import ItDepends

final class TimerSettings: ObservableObject, Codable, JSONModel {
    static let url = FileManager.documentsFolder.appendingPathComponent("settings.json")
    
    static let intervalRange = 1..<181
    
    @Published var interval: TimeInterval = 30
    @Published var sound = SoundUnion.builtin(sounds[0])
    @Published var currentTaskId = Task.default.id {
        didSet {
            if inited, let newInterval = currentTask.interval {
                interval = newInterval
            }
        }
    }
    
    var currentTask: Task {
        taskStore.task(for: currentTaskId)
    }
    
    @Dependency private var taskStore: TaskStore
    
    private var inited = false
    
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
        sound = try container.decode(SoundUnion.self, forKey: .sound)
        currentTaskId = try container.decode(UUID.self, forKey: .currentTaskId)
        inited = true
    }
    
    init() {
        inited = true
    }
}
