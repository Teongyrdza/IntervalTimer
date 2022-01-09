//
//  EditHistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 30.08.2021.
//

import SwiftUI
import StarUI
import ItDepends

struct EditHistoryView: View, Depender {
    @ObservedDependency var taskStore: TaskStore
    @Binding var history: History
    
    func id(for task: Binding<Task>) -> Binding<UUID> {
        .init(
            get: { task.wrappedValue.id },
            set: {
                task.wrappedValue = taskStore.task(for: $0)
            }
        )
    }
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("Name".localized(), text: $history.name)
            }
            
            Section(header: Text("Task")) {
                if let $task = $history.task.propagatingOptional() {
                    NavigationLink {
                        TaskPicker(store: taskStore, selection: id(for: $task))
                    } label: {
                        Text($task.wrappedValue.name)
                    }
                }
                else {
                    Text("None")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            history.task = .default
                        }
                }
            }
            
            Section(header: Text("Date")) {
                DatePicker("", selection: $history.date)
                    .datePickerStyle(.graphical)
            }
            
            ListDataCell("Cycles", history.cycles)
            
            Section(header: Text("Duration")) {
                TimeField(time: $history.duration)
            }
            
            Section(header: Text("Cycle duration")) {
                SingleRowTimePicker(selection: $history.cycleDuration, in: TimerSettings.intervalRange) { (time: TimeInterval) in
                    time.formatted()
                }
                .pickerStyle(.wheel)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct EditHistoryView_Previews: PreviewProvider {
    @State static var history = History.exampleData[0]
    
    static var previews: some View {
        EditHistoryView(history: $history)
            .withDependencies(from: .default())
    }
}
