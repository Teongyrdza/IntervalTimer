//
//  ContentView.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI
import StarUI
import AVFoundation

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(value: viewModel.timeRemaining)
                    .progressViewStyle(CircularProgressViewStyle(thickness: 30))
                
                Text(viewModel.alarmText)
            }
            
            HStack {
                Group {
                    if viewModel.state == .stopped {
                        Button("Start") {
                            viewModel.state = .running
                        }
                        .accentColor(.green)
                    }
                    else {
                        Button("Stop") {
                            viewModel.state = .stopped
                        }
                        .accentColor(.init("AccentColor"))
                    }
                }
                .frame(width: 75)
                
                Spacer()
                
                Button("Cancel") {
                    viewModel.state = .hidden
                }
                .frame(width: 75)
                .accentColor(.gray)
            }
            .buttonStyle(RoundedCornersButtonStyle(lineWidth: 7.5, cornerRadius: 10))
            .frame(height: 50)
            .padding(.bottom)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .navigationTitle("Interval Timer")
        .onAppear { viewModel.state = .running }
    }
}

#if DEBUG
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimerView(viewModel: .init(showing: .constant(true)))
        }
    }
}
#endif
