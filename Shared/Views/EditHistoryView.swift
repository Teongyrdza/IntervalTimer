//
//  EditHistoryView.swift
//  IntervalTimer
//
//  Created by Ostap on 30.08.2021.
//

import SwiftUI
import StarUI

struct EditHistoryView: View {
    @Binding var history: History
    
    var body: some View {
        List {
            Section(header: Text("Name")) {
                TextField("Name".localized(), text: $history.name)
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
                SingleRowTimePicker(selection: $history.cycleDuration, in: TimerSettings.intervalRange)
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
    }
}
