//
//  HistoryStore.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import Combine

class HistoryStore: ObservableObject {
    @Published var histories = [History]()
}
