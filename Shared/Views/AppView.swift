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
    @Dependency var modelStore: ModelStore
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    @State var timerShowing = false
    
    var soundStore: SoundStore { modelStore.model(ofType: SoundStore.self)! }
    
    var body: some View {
        TabView {
            NavigationView {
                if timerShowing {
                    TimerView(
                        viewModel: TimerViewModel(showing: $timerShowing)
                            .withDependencies(from: modelStore)
                    )
                }
                else {
                    SettingsView(timerShowing: $timerShowing)
                        .withDependencies(from: modelStore)
                }
            }
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }
            
            NavigationView {
                HistoryView()
                    .withDependencies(from: modelStore)
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("History")
            }
            
            NavigationView {
                TasksView()
                    .withDependencies(from: modelStore)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }
            
            NavigationView {
                SoundList(store: soundStore)
            }
            .tabItem {
                Image(systemName: "music.note.list")
                Text("Sounds")
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { newPhase in
            modelStore.save()
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
