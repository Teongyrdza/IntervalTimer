//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI

@main
struct IntervalTimerApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
        }
    }
    
    // MARK: - Background execution
    /*
    #if os(iOS)
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    mutating func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
    
    mutating func moveToBackground() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [self] in
            endBackgroundTask()
        }
    }
    
    mutating func enterForeground() {
        endBackgroundTask()
    }
    #endif
    */
}
