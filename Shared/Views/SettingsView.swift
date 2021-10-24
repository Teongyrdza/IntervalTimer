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
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Time interval")
                        .font(.system(size: 30))
                    
                    SingleRowTimePicker(selection: $settings.interval, in: TimerSettings.intervalRange)
                        .pickerStyle(.wheel)
                    
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
                
                Group {
                    Button("Start") {
                        timerShowing.wrappedValue = true
                    }
                    .frame(width: 150)
                    
                    Button("Next") {
                        if let nextTaskId = settings.currentTask?.nextTaskId {
                            settings.currentTaskId = nextTaskId
                        }
                        timerShowing.wrappedValue = true
                    }
                    .frame(width: 150)
                }
                .buttonStyle(.roundedCorners(lineWidth: 7.5, cornerRadius: 10))
                .accentColor(.green)
                .frame(height: 50)
                .padding(.horizontal, 20)
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
