//
//  AppView.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import SwiftUI

struct AppView: View {
    @StateObject var settings = TimerSettings()
    @State var timerShowing = false
    
    var body: some View {
        TabView {
            NavigationView {
                if timerShowing {
                    TimerView()
                }
                else {
                    SettingsView()
                }
            }
            .environmentObject(settings)
            .environment(\.timerShowing, $timerShowing)
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }
            
            NavigationView {
                Text("History")
            }
            .tabItem {
                Image(systemName: "books.vertical")
                Text("History")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
#endif
