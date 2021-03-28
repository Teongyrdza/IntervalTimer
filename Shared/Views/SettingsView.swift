//
//  SettingsView.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import SwiftUI
import AVFoundation

struct SoundPicker: View {
    @Binding var selection: Sound
    @State private var isPlaying = false
    
    private var player: AVPlayer {
        selection.player
    }
    
    var body: some View {
        List {
            ForEach(Sound.allCases, id: \.self) { sound in
                Text(sound.description)
                    .onTapGesture {
                        // Stop previous sound, if playing
                        if isPlaying {
                            isPlaying = false
                            player.pause()
                        }
                        
                        if selection != sound || !isPlaying {
                            selection = sound
                            isPlaying = true
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings: TimerSettings
    @Environment(\.timerShowing) var timerShowing
    
    func metric(forSeconds seconds: Int) -> String {
        return seconds == 1 ? "second" : "seconds"
    }
    
    func metric(forMinutes minutes: Int) -> String {
        return minutes == 1 ? "minute" : "minutes"
    }
    
    func label(for time: Int) -> String {
        if time < 60 {
            return "\(time) \(metric(forSeconds: time))"
        }
        else {
            let minutes = time / 60
            let seconds = time % 60
            
            return String(
                format: "%d %@ %02d %@",
                minutes, metric(forMinutes: minutes), seconds, metric(forSeconds: seconds)
            )
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Divider()
                        .padding(.bottom)
                    
                    Text("Time interval")
                        .font(.system(size: 30))
                        .padding(.horizontal)
                    
                    Picker("", selection: $settings.interval) {
                        ForEach(0..<181) { time in
                            Text(label(for: time)).tag(TimeInterval(time    ))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Button("Start") {
                    timerShowing.wrappedValue = true
                }
                .buttonStyle(RoundedButtonStyle(lineWidth: 7.5, cornerRadius: 10))
                .frame(width: 150, height: 50)
                .accentColor(.green)
                .padding(.top)
                
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
                .padding(.top)
                .padding(.horizontal)
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
