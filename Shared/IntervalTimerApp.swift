//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI

@main
struct IntervalTimerApp: App {
    @StateObject var settings = TimerSettings.load()
    @StateObject var historyStore = HistoryStore.load()
    @StateObject var taskStore = TaskStore.load()
    
    var body: some Scene {
        WindowGroup {
            AppView(settings: settings, historyStore: historyStore, taskStore: taskStore)
        }
    }
}
