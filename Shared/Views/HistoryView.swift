//
//  HistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import SwiftUI
import ItDepends

struct HistoryView: View, Depender {
    @ObservedDependency var store: HistoryStore
    @State var inserting = false
    
    var body: some View {
        Group {
            if store.histories.isEmpty {
                Text("The history is empty")
                    .foregroundColor(.gray)
            }
            else {
                List {
                    ForEach(store.histories.toArray().reversed()) { history in
                        let historyBinding = store.binding(for: history)
                        
                        NavigationLink(destination: HistoryDetail(history: historyBinding)) {
                            VStack(alignment: .leading) {
                                Text(history.name)
                                    .font(.body.bold())
                                
                                Spacer()
                                
                                Text(history.dateString)
                            }
                        }
                        .listRowBackground(history.color)
                    }
                    .onDelete { indices in
                        // Remove from the start, because indices are reversed
                        for index in indices {
                            store.histories.remove(at: store.histories.count - 1 - index)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    inserting = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $inserting) {
            AddHistoryView(isPresented: $inserting, store: store)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
                .withDependencies(from: ModelStore.default())
        }
        .navigationViewStyle(.stack)
    }
}
