//
//  TaskPicker.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI
import Foundation

struct TaskPicker: View {
    @ObservedObject var store = TaskStore()
    @Binding var selection: UUID
    
    var body: some View {
        List {
            ForEach(store.tasks.toArray()) { task in
                Button {
                    selection = task.id
                } label: {
                    Text(task.name)
                        .foregroundColor(.primary)
                }
                .if(selection == task.id)
                .listRowBackground(Color.accentColor)
                .endif()
            }
        }
        .listStyle(.grouped)
    }
}

struct TaskPicker_Previews: PreviewProvider {
    @State static var id = Task.default.id
    
    static var previews: some View {
        TaskPicker(selection: $id)
    }
}
