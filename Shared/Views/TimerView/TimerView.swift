//
//  ContentView.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    @StateObject var timer = IntervalTimer(every: 15)
    @EnvironmentObject var settings: TimerSettings
    @Environment(\.timerShowing) var isShowing: Binding<Bool>
    
    var player: AVPlayer { settings.sound.player }
    
    var secondsRemaining: Int {
        Int(timer.timeRemaining) % 60
    }
    
    var secondsRemainingMetric: String {
        secondsRemaining == 1 ? "second" : "seconds"
    }
    
    var minutesRemaining: Int {
        Int(timer.timeRemaining) / 60
    }
    
    var minutesRemainingMetric: String {
        minutesRemaining == 1 ? "minute" : "minutes"
    }
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: timer.timeRemaining, total: timer.refreshTime)
                    .progressViewStyle(CircularProgressViewStyle(thickness: 30))
                
                if timer.timeRemaining < 60 {
                    Text("Alarm in \(secondsRemaining) \(secondsRemainingMetric)")
                }
                else {
                    Text("Alarm in \(minutesRemaining) \(minutesRemainingMetric) \(secondsRemaining) \(secondsRemainingMetric)")
                }
            }
            
            HStack {
                Button(!timer.isRunning ? "Start" : "Stop") {
                    if timer.isRunning {
                        timer.stopCycle()
                    }
                    else {
                        timer.startCycle()
                    }
                }
                .frame(width: 75)
                .accentColor(timer.isRunning ? .init("AccentColor") : .green)
                
                Spacer()
                
                Button("Cancel") {
                    timer.stopCycle()
                    isShowing.wrappedValue = false
                }
                .frame(width: 75)
                .accentColor(.gray)
            }
            .buttonStyle(RoundedButtonStyle(lineWidth: 7.5, cornerRadius: 10))
            .frame(height: 50)
            .padding(.bottom)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .navigationTitle("Interval Timer")
        .onAppear {
            timer.refreshTime = settings.interval
            timer.startCycle()
        }
        .onDisappear {
            timer.stopCycle()
        }
        .onReceive(timer.intervalPassed) { _ in
            player.seek(to: .zero)
            player.play()
        }
    }
}

#if DEBUG
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerView()
        }
        .environmentObject(TimerSettings())
    }
}
#endif
