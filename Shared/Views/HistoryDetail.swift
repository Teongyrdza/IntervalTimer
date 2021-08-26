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
    let history: History
    
    var body: some View {
        List {
            ListDataCell("Date:", history.dateString)
            
            ListDataCell("Cycles:", history.cycles)
            
            ListDataCell("Duration:", history.duration.formatted())
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(history.name)
    }
}

struct HistoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryDetail(history: .exampleData[0])
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
