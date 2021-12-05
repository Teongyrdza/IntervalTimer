//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI
import SoundKit

@main
struct IntervalTimerApp: App {
    @StateObject var settings = TimerSettings.load()
    @StateObject var historyStore = HistoryStore.load()
    @StateObject var taskStore = TaskStore.load()
    @StateObject var soundStore = SoundStore.load()
    
    let startTime = Date().timeIntervalSince1970
    
    var body: some Scene {
        WindowGroup {
            AppView(settings: settings, historyStore: historyStore, taskStore: taskStore, soundStore: soundStore)
                .onAppear {
                    settings.taskStore = taskStore
                    
                    let now = Date().timeIntervalSince1970
                    let elapsed = now - startTime
                    print("Startup took \(elapsed, specifier: "%.2f") seconds")
                }
        }
    }
}
