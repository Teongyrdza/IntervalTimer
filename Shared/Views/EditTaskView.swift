//
//  EditTaskView.swift
//  IntervalTimer
//
//  Created by Ostap on 27.08.2021.
//

import SwiftUI
import StarUI

struct EditTaskView: View {
    @Binding var task: Task
    @State var interval = 5.0
    
    var intervalBinding: Binding<TimeInterval> {
        .init(
            get: {
                switch task.interval {
                    case .setValue(let interval):
                        return interval
                    case .asBefore:
                        return self.interval
                }
            },
            set: { newValue in
                interval = newValue
                task.interval = .setValue(newValue)
            }
        )
    }
    
    var alterIntervalBinding: Binding<Bool> {
        .init(
            get: {
                if case .setValue(_) = task.interval {
                    return true
                }
                return false
            },
            set: { newValue in
                if newValue {
                    task.interval = .setValue(interval)
                }
                else {
                    task.interval = .asBefore
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
                
                if alterIntervalBinding.wrappedValue {
                    VStack(alignment: .leading) {
                        Text("Time interval:")
                        
                        SingleRowTimePicker(selection: intervalBinding, in: TimerSettings.intervalRange)
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
