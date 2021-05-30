//
//  SettingsView.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import SwiftUI
import StarUI
import AVFoundation

struct SettingsView: View {
    @EnvironmentObject var settings: TimerSettings
    @Environment(\.timerShowing) var timerShowing
    let showBorders = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Time interval")
                        .font(.system(size: 30))
                        .border(Color.gray, if: showBorders)
                    
                    TimePicker("Time Interval", selection: $settings.interval, in: 1..<181)
                        .border(Color.green, if: showBorders)
                    
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
                    .border(Color.yellow, if: showBorders)
                }
                
                Button("Start") {
                    timerShowing.wrappedValue = true
                }
                .buttonStyle(RoundedButtonStyle(lineWidth: 7.5, cornerRadius: 10))
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
