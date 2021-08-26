//
//  HistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var store: HistoryStore
    
    var body: some View {
        Group {
            if store.histories.isEmpty {
                Text("The history is empty")
                    .foregroundColor(.gray)
            }
            else {
                List {
                    ForEach(store.histories.reversed()) { history in
                        NavigationLink(destination: HistoryDetail(history: history)) {
                            VStack(alignment: .leading) {
                                Text(history.name)
                                    .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text(history.dateString)
                            }
                        }
                    }
                    .onDelete { indices in
                        // Remove from the start, because indices are reversed
                        for index in indices {
                            store.histories.remove(at: store.histories.count - 1 - index)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView(store: .init())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
