//
//  AddHistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 04.09.2021.
//

import SwiftUI

struct AddHistoryView: View {
    @Binding var isPresented: Bool
    @ObservedObject var store = HistoryStore()
    @State var history = History(name: "", duration: 0, cycleDuration: 15)
    
    var body: some View {
        NavigationView {
            EditHistoryView(history: $history)
                .navigationTitle("Add history")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isPresented = false
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            store.insert(history)
                            isPresented = false
                        }
                    }
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddHistoryView(isPresented: .constant(true))
    }
}
