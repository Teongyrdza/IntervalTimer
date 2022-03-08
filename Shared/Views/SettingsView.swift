//
//  SettingsView.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import SwiftUI
import StarUI
import SoundKit
import ItDepends

struct SettingsView: View, Depender {
    @ObservedDependency var settings: TimerSettings
    @ObservedDependency var taskStore: TaskStore
    @ObservedDependency var soundStore: SoundStore
    @Dependency var modelStore: ModelStore
    @State var timerShowing = false
    
    var body: some View {
        ScrollView {
            VStack {
                Divider()
                    .padding(.bottom)
                
                HStack {
                    Text("Interval")
                        .font(.system(size: 30))
                
                    Spacer()
                }
                
                SingleRowTimePicker(selection: $settings.interval, in: TimerSettings.intervalRange) { (time: TimeInterval) in
                    time.formatted()
                }
                .pickerStyle(.wheel)
                
                BoxPicker("When interval ends", label: settings.sound.name) {
                    SoundPicker(
                        selection: $settings.sound,
                        sounds: soundStore.sounds,
                        builtinSounds: sounds
                    )
                    .listStyle(.grouped)
                    .navigationTitle("When interval ends")
                }
                
                BoxPicker("Task", label: settings.currentTask.name) {
                    TaskPicker(store: taskStore, selection: $settings.currentTaskId)
                        .navigationTitle("Task")
                }
                .padding(.bottom, 10)
                
                Group {
                    Button("Start") {
                        timerShowing = true
                    }
                    .padding(.bottom, 10)
                    
                    Button("Next") {
                        if let nextTaskId = settings.currentTask.nextTaskId {
                            settings.currentTaskId = nextTaskId
                        }
                        timerShowing = true
                    }
                    .padding(.bottom, 5)
                }
                .buttonStyle(
                    .roundedCorners(
                        lineWidth: 7.5,
                        cornerRadius: 10,
                        insets: .init(horizontal: 50, vertical: 30)
                    )
                )
                .accentColor(.green)
            }
        }
        .navigationTitle("Time Guardian")
        .padding()
        .fullScreenCover(isPresented: $timerShowing) {
            NavigationView {
                TimerView(viewModel: .init(showing: $timerShowing).withDependencies(from: modelStore))
                    .navigationTitle("Time Guardian")
            }
            .navigationViewStyle(.stack)
        }
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    @State static var time: TimeInterval = 30
    
    static var previews: some View {
        NavigationView {
            SettingsView()
                .withDependencies(from: ModelStore.default())
        }
    }
}
#endif
