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
    @State var task = Task("", record: true)
    
    var body: some View {
        NavigationView {
            EditTaskView(task: $task)
                .navigationTitle("Add task")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isPresented = false
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            taskStore.insert(task)
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
