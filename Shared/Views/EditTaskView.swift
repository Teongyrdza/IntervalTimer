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
    @Binding var task: Task
    @State var interval = 5.0
    
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
    
    var body: some View {
        NavigationView {
            List {
                TextField("Name", text: $task.name)
                
                Toggle("Record history", isOn: $task.record)
                
                Toggle("Alter time interval", isOn: alterIntervalBinding)
                
                if let $taskInterval = $task.interval.propagatingOptional() {
                    VStack(alignment: .leading) {
                        Text("Time interval:")
                        
                        SingleRowTimePicker(selection: $taskInterval, in: TimerSettings.intervalRange)
                            .pickerStyle(.wheel)
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationViewStyle(.stack)
    }
}

struct EditTaskView_Previews: PreviewProvider {
    @State static var task: Task = .default
    
    static var previews: some View {
        EditTaskView(task: $task)
    }
}
