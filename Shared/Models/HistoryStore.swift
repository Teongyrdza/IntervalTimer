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

final class HistoryStore: ObservableObject, Codable, DefaultConstructible {
    @Published var histories = [History]()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(histories)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        histories = try container.decode([History].self)
    }
    
    init() {}
}

extension HistoryStore {
    private static let url = DataStore.historyUrl
    
    static func load() -> Self {
        DataStore.load(self, from: url)
    }
    
    func save() {
        DataStore.save(self, to: Self.url)
    }
}
