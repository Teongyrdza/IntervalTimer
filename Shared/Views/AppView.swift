//
//  AppView.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var settings = TimerSettings()
    @ObservedObject var historyStore = HistoryStore()
    @ObservedObject var taskStore = TaskStore()
    @Environment(\.scenePhase) var scenePhase: ScenePhase
    @State var timerShowing = false
    
    var viewModelFactory: ViewModelFactory {
        ViewModelFactory(
            timerSettings: settings, historyStore: historyStore, taskStore: taskStore
        )
    }
    
    var body: some View {
        TabView {
            NavigationView {
                if timerShowing {
                    TimerView(
                        viewModel: viewModelFactory.makeTimerViewModel(showing: $timerShowing)
                    )
                }
                else {
                    SettingsView(settings: settings, taskStore: taskStore)
                }
            }
            .environment(\.timerShowing, $timerShowing)
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }
            
            NavigationView {
                HistoryView(store: historyStore)
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("History")
            }
            
            NavigationView {
                TasksView(taskStore: taskStore)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                settings.save()
                historyStore.save()
                taskStore.save()
            }
        }
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
#endif
