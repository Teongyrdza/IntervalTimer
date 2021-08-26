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
    @Published var policies = OrderedDictionary<UUID, HistoryPolicy>()
    @Published var policyId = HistoryPolicy.default.id
    
    var policyArray: [HistoryPolicy] {
        Array(policies.values)
    }
    
    var currentPolicy: HistoryPolicy {
        policy(for: policyId)
    }
    
    func policy(for id: UUID) -> HistoryPolicy {
        policies[id] ?? .default
    }
    
    func binding(for policy: HistoryPolicy) -> Binding<HistoryPolicy> {
        .init(
            get: { self.policy(for: policy.id) },
            set: { [self] in policies[policy.id] = $0 }
        )
    }
    
    func insert(policy: HistoryPolicy) {
        policies[policy.id] = policy
    }
    
    func deletePolicy(at index: Int) {
        policies.remove(at: index)
    }
    
    init() {
        insert(policy: .default)
    }
}
