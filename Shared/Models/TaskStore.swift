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
import ItDepends

final class TaskStore: ObservableObject, Codable, JSONModel {
    static let url = FileManager.documentsFolder.appendingPathComponent("tasks.json")
    
    @Published var tasks = OrderedDictionary<UUID, Task>()
    
    private var cancellables = Set<AnyCancellable>()

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
        
        task.objectWillChange
            .pipe(to: objectWillChange)
            .store(in: &cancellables)
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
        let tasks = try container.decode(OrderedDictionary<UUID, Task>.self)
        for task in tasks.values {
            insert(task)
        }
    }
    
    init() {
        insert(Task.default)
    }
}
