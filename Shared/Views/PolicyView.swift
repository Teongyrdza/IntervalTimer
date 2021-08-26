//
//  PolicyView.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI
import StarUI

struct PolicyView: View {
    @ObservedObject var historyStore = HistoryStore()
    @State var inserting = false
    
    var body: some View {
        Group {
            if historyStore.policies.isEmpty {
                Text("There are no tasks")
                    .foregroundColor(.gray)
            }
            else {
                List {
                    ForEach(historyStore.policyArray) { policy in
                        let binding = historyStore.binding(for: policy)
                        
                        VStack {
                            TextField("Name", text: binding.name)
                                .font(.headline.bold())
                            
                            Toggle("Record history", isOn: binding.record)
                        }
                    }
                    .onDelete { indices in
                        for index in indices {
                            historyStore.deletePolicy(at: index)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    inserting = true
                }
            }
        }
        .sheet(isPresented: $inserting) {
            AddPolicyView(isPresented: $inserting, historyStore: historyStore)
        }
    }
}

struct PolicyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PolicyView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
