//
//  AddPolicyView.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI

struct AddPolicyView: View {
    @Binding var isPresented: Bool
    @ObservedObject var historyStore = HistoryStore()
    @State var name = ""
    @State var record = true
    
    var body: some View {
        NavigationView {
            List {
                TextField("Name", text: $name)
                
                Toggle("Record history", isOn: $record)
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Add task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        historyStore.insert(policy: .init(name, record: record))
                        isPresented = false
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        AddPolicyView(isPresented: .constant(true))
    }
}
