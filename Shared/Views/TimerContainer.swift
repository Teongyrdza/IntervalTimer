//
//  TimerContainer.swift
//  IntervalTimer
//
//  Created by Ostap on 15.12.2021.
//

import SwiftUI
import ItDepends

struct TimerContainer: View, Depender {
    @ObservedDependency var modelStore: ModelStore
    @State var timerShowing = false
    
    var body: some View {
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
}

#if DEBUG
struct TimerContainer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerContainer()
                .withDependencies(from: ModelStore.default())
        }
        .navigationViewStyle(.stack)
    }
}
#endif
