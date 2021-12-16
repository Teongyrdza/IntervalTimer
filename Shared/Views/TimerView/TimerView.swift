//
//  ContentView.swift
//  Shared
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI
import StarUI
import ItDepends

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
                Button(viewModel.leftButtonText) {
                    viewModel.leftButtonTapped()
                }
                .accentColor(viewModel.leftButtonColor)
                
                Spacer()
                
                Button("Cancel") {
                    viewModel.rightButtonTapped()
                }
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
            TimerView(
                viewModel: .init(showing: .constant(true))
                    .withDependencies(from: ModelStore.default())
            )
        }
    }
}
#endif
