//
//  IntervalTimerApp.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI
import SoundKit
import ItDepends
import AVFAudio

extension ModelStore {
    static func `default`() -> Self {
        .init(TimerSettings.self, HistoryStore.self, TaskStore.self, SoundStore.self)
    }
}

@main
struct IntervalTimerApp: App {
    @StateObject var modelStore = ModelStore.default()
    
    let startTime = Date().timeIntervalSince1970
    
    var body: some Scene {
        WindowGroup {
            AppView()
                .withDependencies(from: modelStore)
                .onAppear {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback)
                        try AVAudioSession.sharedInstance().setActive(true)
                    } catch {
                        print("Error configuring audio session")
                    }
                    
                    print(FileManager.documentsFolder)
                    
                    let now = Date().timeIntervalSince1970
                    let elapsed = now - startTime
                    print("Startup took \(elapsed, specifier: "%.2f") seconds")
                }
        }
    }
}
