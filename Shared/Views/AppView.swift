//
//  AppView.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var historyStore: HistoryStore
    @StateObject var settings = TimerSettings()
    @State var timerShowing = false
    
    var viewModelFactory: ViewModelFactory {
        ViewModelFactory(timerSettings: settings, historyStore: historyStore)
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
                    SettingsView(settings: settings, historyStore: historyStore)
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
                PolicyView(historyStore: historyStore)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(historyStore: .init())
    }
}
#endif
