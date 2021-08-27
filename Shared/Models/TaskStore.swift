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

class TaskStore: ObservableObject {
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

    init() {
        insert(Task.default)
    }
}
