//
//  AddHistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 04.09.2021.
//

import SwiftUI
import ItDepends

struct AddHistoryView: View, Depender {
    @ObservedDependency var modelStore: ModelStore
    @ObservedDependency var store: HistoryStore
    @Binding var isPresented: Bool
    @State var history = History(name: "", duration: 0, cycleDuration: 15)
    
    var body: some View {
        NavigationView {
            EditHistoryView(history: $history)
                .withDependencies(from: modelStore)
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
        .navigationViewStyle(.stack)
    }
}

struct AddHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddHistoryView(isPresented: .constant(true))
            .withDependencies(from: .default())
    }
}
