//
//  HistoryDetail.swift
//  IntervalTimer
//
//  Created by Ostap on 25.08.2021.
//

import SwiftUI

struct DataCell: View {
    let label: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .fontWeight(.bold)
            
            Spacer()
            
            Text(content)
        }
    }
    
    init(_ label: String, _ content: CustomStringConvertible) {
        self.label = label
        self.content = "\(content)"
    }
}

struct ListDataCell: View {
    let label: String
    let content: String
    
    var body: some View {
        Section(header: Text(label)) {
            Text(content)
        }
    }
    
    init(_ label: String, _ content: CustomStringConvertible) {
        self.label = label
        self.content = "\(content)"
    }
}

struct HistoryDetail: View {
    @Binding var history: History
    @State var editing = false
    @State var tempHistory = History.exampleData[0]
    
    var body: some View {
        List {
            ListDataCell("Date", history.dateString)
            
            ListDataCell("Cycles", history.cycles)
            
            ListDataCell("Duration", history.duration.formatted())
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(history.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    tempHistory = history
                    editing = true
                }
            }
        }
        .sheet(isPresented: $editing) {
            NavigationView {
                EditHistoryView(history: $tempHistory)
                    .navigationTitle(tempHistory.name)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                editing = false
                            }
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                history = tempHistory
                                editing = false
                            }
                        }
                    }
            }
        }
    }
}

struct HistoryDetail_Previews: PreviewProvider {
    @State static var history = History.exampleData[0]
    
    static var previews: some View {
        NavigationView {
            HistoryDetail(history: $history)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
