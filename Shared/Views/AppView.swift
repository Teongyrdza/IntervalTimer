//
//  AppView.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import SwiftUI
import SoundKit
import ItDepends

struct AppView: View, Depender {
    static let screens = [
        Screen("Timer", icon: "timer", content: TimerContainer.init),
        Screen("History", icon: "books.vertical", content: HistoryView.init),
        Screen("Tasks", icon: "list.bullet", content: TasksView.init),
        Screen("Sounds", icon: "music.note.list") { modelStore in
            SoundList(store: modelStore.model(ofType: SoundStore.self)!)
        }
    ]
    
    @Dependency var modelStore: ModelStore
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    
    var body: some View {
        TabView {
            ForEach(Self.screens) { screen in
                NavigationView {
                    screen.content(modelStore)
                }
                .tabItem {
                    Text(screen.label)
                    if let icon = screen.icon {
                        Image(systemName: icon)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { newPhase in
            if newPhase != .active {
                modelStore.save()
            }
        }
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .withDependencies(from: ModelStore.default())
    }
}
#endif
