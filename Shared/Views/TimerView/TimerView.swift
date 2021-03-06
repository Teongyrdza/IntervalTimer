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
                    .progressViewStyle(.circular(thickness: 30))
                
                Text(viewModel.alarmText)
            }
            
            HStack {
                Button(viewModel.leftButtonText) {
                    viewModel.leftButtonTapped()
                }
                .accentColor(viewModel.leftButtonColor)
                
                Spacer()
                
                Button("Done") {
                    viewModel.rightButtonTapped()
                }
                .accentColor(.gray)
            }
            .buttonStyle(
                .roundedCorners(lineWidth: 7.5, cornerRadius: 10, insets: .init(vertical: 30))
            )
            .padding(.bottom)
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .navigationTitle("Time Guardian")
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
