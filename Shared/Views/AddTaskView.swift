//
//  AddTaskView.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var isPresented: Bool
    @ObservedObject var taskStore = TaskStore()
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
                        taskStore.insert(task: .init(name, record: record))
                        isPresented = false
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(isPresented: .constant(true))
    }
}
