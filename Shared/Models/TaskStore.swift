//
//  TaskStore.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI
import Foundation
import Combine
import OrderedCollections

final class TaskStore: ObservableObject, Codable, DefaultConstructible {
    @Published var tasks = OrderedDictionary<UUID, Task>()

    var taskArray: [Task] {
        Array(tasks.values)
    }

    func task(for id: UUID) -> Task {
        tasks[id] ?? .default
    }

    func binding(for task: Task) -> Binding<Task> {
        .init(
            get: { self.task(for: task.id) },
            set: { [self] in tasks[task.id] = $0 }
        )
    }

    func insert(_ task: Task) {
        tasks[task.id] = task
    }

    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(tasks)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        tasks = try container.decode(OrderedDictionary<UUID, Task>.self)
    }
    
    init() {
        insert(Task.default)
    }
}

extension TaskStore {
    private static let url = DataStore.tasksUrl
    
    static func load() -> Self {
        DataStore.load(self, from: url)
    }
    
    func save() {
        DataStore.save(self, to: Self.url)
    }
}
