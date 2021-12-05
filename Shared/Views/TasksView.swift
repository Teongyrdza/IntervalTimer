//
//  TasksView.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI
import StarUI
import Introspect

struct TasksView: View {
    @ObservedObject var taskStore = TaskStore()
    @State var inserting = false
    
    func view(for task: Binding<Task>) -> some View {
        VStack {
            TextField("Name".localized(), text: task.name)
                .font(.headline.bold())
            
            Toggle("Record history", isOn: task.record)
        }
    }
    
    var body: some View {
        Group {
            if taskStore.tasks.isEmpty {
                Text("There are no tasks")
                    .foregroundColor(.gray)
            }
            else {
                List {
                    ForEach(taskStore.tasks.toArray()) { task in
                        let binding = taskStore.binding(for: task)
                        
                        NavigationLink(
                            destination: EditTaskView(taskStore: taskStore, task: binding).navigationTitle(task.name)
                        ) {
                            view(for: binding)
                        }
                        #if !targetEnvironment(simulator)
                        .hidden()
                        .background(view(for: binding))
                        #endif
                    }
                    .onDelete { indices in
                        for index in indices {
                            taskStore.removeTask(at: index)
                        }
                    }
                }
                .listStyle(.grouped)
                .introspectTableViewCell { cell in
                    cell.accessoryType = .none
                }
            }
        }
        .navigationTitle("Tasks")
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
            AddTaskView(isPresented: $inserting, taskStore: taskStore)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TasksView()
        }
        .navigationViewStyle(.stack)
    }
}
