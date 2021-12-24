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
    @Binding var timerShowing: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Time interval")
                        .font(.system(size: 30))
                    
                    SingleRowTimePicker(selection: $settings.interval, in: TimerSettings.intervalRange) { (time: TimeInterval) in
                        time.formatted()
                    }
                    .pickerStyle(.wheel)
                    
                    GroupBox {
                        HStack {
                            Text("When interval ends")
                            
                            Spacer()
                            
                            NavigationLink(
                                destination:
                                    SoundPicker(
                                        selection: $settings.sound,
                                        sounds: soundStore.sounds,
                                        builtinSounds: sounds
                                    )
                                    .listStyle(.grouped)
                            ) {
                                Text(settings.sound.name)
                                    .opacity(0.5)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    GroupBox {
                        HStack {
                            Text("Task")
                            
                            Spacer()
                            
                            NavigationLink {
                                TaskPicker (
                                    store: taskStore,
                                    selection: $settings.currentTaskId
                                )
                            } label: {
                                Text(taskStore.task(for: settings.currentTaskId).name)
                                    .opacity(0.5)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
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
        .navigationTitle("Settings")
        .padding()
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    @State static var time: TimeInterval = 30
    
    static var previews: some View {
        NavigationView {
            SettingsView(timerShowing: .constant(false))
                .withDependencies(from: ModelStore.default())
        }
    }
}
#endif
