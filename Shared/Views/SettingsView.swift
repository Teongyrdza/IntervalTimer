//
//  SettingsView.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import SwiftUI
import StarUI
import Foundation

struct SettingsView: View {
    @ObservedObject var settings = TimerSettings()
    @ObservedObject var taskStore = TaskStore()
    @Environment(\.timerShowing) var timerShowing
    
    var taskIdBinding: Binding<UUID> {
        .init(
            get: { settings.currentTaskId },
            set: { newId in
                settings.currentTaskId = newId
                settings.currentTaskIntervalChanged(to: taskStore.task(for: newId).interval)
            }
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Time interval")
                        .font(.system(size: 30))
                    
                    SingleRowTimePicker(selection: $settings.interval, in: TimerSettings.intervalRange)
                    
                    GroupBox {
                        HStack {
                            Text("When interval ends")
                            
                            Spacer()
                            
                            NavigationLink(destination: SoundPicker(selection: $settings.sound)) {
                                Text(settings.sound.description)
                                    .opacity(0.5)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    GroupBox {
                        HStack {
                            Text("Task")
                            
                            Spacer()
                            
                            NavigationLink(
                                destination: TaskPicker(
                                    store: taskStore,
                                    selection: taskIdBinding
                                )
                            ) {
                                Text(taskStore.task(for: settings.currentTaskId).name)
                                    .opacity(0.5)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Button("Start") {
                    timerShowing.wrappedValue = true
                }
                .buttonStyle(RoundedCornersButtonStyle(lineWidth: 7.5, cornerRadius: 10))
                .frame(width: 150, height: 50)
                .accentColor(.green)
                .padding(.top)
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
            SettingsView()
                .environmentObject(TimerSettings())
        }
    }
}
#endif
