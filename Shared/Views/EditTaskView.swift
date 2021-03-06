//
//  EditTaskView.swift
//  IntervalTimer
//
//  Created by Ostap on 27.08.2021.
//

import SwiftUI
import StarUI

extension Binding {
    func propagatingOptional<T>() -> Binding<T>? where Value == T? {
        if let wrappedValue = wrappedValue {
            return .init(
                get: { wrappedValue },
                set: { self.wrappedValue = $0 }
            )
        }
        return nil
    }
}

struct EditTaskView: View {
    @ObservedObject var taskStore = TaskStore()
    @Binding var task: Task
    @State var interval = 5.0
    @State var recommendedDuration: TimeInterval = 5 * 60
    
    var alterIntervalBinding: Binding<Bool> {
        .init(
            get: { task.interval != nil },
            set: { newValue in
                if newValue {
                    task.interval = interval
                }
                else {
                    task.interval = nil
                }
            }
        )
    }
    
    var recommendDuration: Binding<Bool> {
        .init(
            get: { task.recommendedDuration != nil },
            set: { newValue in
                if newValue {
                    task.recommendedDuration = recommendedDuration
                }
                else {
                    task.recommendedDuration = nil
                }
            }
        )
    }
    
    var body: some View {
        List {
            TextField("Name".localized(), text: $task.name)
            
            Toggle("Record history", isOn: $task.record)
            
            Toggle("Alter time interval", isOn: alterIntervalBinding)
            
            if let $taskInterval = $task.interval.propagatingOptional() {
                VStack(alignment: .leading) {
                    Text("Time interval")
                    
                    SingleRowTimePicker(selection: $taskInterval, in: TimerSettings.intervalRange) { (time: TimeInterval) in
                        time.formatted()
                    }
                    .pickerStyle(.wheel)
                }
            }
            
            VStack(alignment: .leading) {
                Toggle("Recommended duration", isOn: recommendDuration)
                
                if let $recommendedDuration = $task.recommendedDuration.propagatingOptional() {
                    TimeField(time: $recommendedDuration)
                }
            }
            
            NavigationLink {
                TaskPicker(store: taskStore, selection: $task.nextTaskId.replacingNilWith(task.id))
                    .navigationTitle("Next task")
            } label: {
                Text("Next task")
            }
        }
        .listStyle(.grouped)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    @State static var task: Task = .default
    
    static var previews: some View {
        EditTaskView(task: $task)
    }
}
