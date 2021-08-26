//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI

@main
struct IntervalTimerApp: App {
    @StateObject var historyStore = HistoryStore()
    
    var body: some Scene {
        WindowGroup {
            AppView(historyStore: historyStore)
        }
    }
}
