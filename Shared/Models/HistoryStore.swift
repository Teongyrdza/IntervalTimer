//
//  HistoryStore.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import SwiftUI
import Foundation
import Combine
import OrderedCollections

class HistoryStore: ObservableObject {
    @Published var histories = [History]()
    @Published var policies = OrderedDictionary<UUID, Task>()
    @Published var policyId = Task.default.id
    
    var policyArray: [Task] {
        Array(policies.values)
    }
    
    var currentPolicy: Task {
        policy(for: policyId)
    }
    
    func policy(for id: UUID) -> Task {
        policies[id] ?? .default
    }
    
    func binding(for policy: Task) -> Binding<Task> {
        .init(
            get: { self.policy(for: policy.id) },
            set: { [self] in policies[policy.id] = $0 }
        )
    }
    
    func insert(policy: Task) {
        policies[policy.id] = policy
    }
    
    func deletePolicy(at index: Int) {
        policies.remove(at: index)
    }
    
    init() {
        insert(policy: .default)
    }
}
