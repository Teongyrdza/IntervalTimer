//
//  PolicyPicker.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import SwiftUI
import Foundation

struct PolicyPicker: View {
    @ObservedObject var store = HistoryStore()
    @Binding var selection: UUID
    
    var body: some View {
        List {
            ForEach(store.policyArray) { policy in
                Text(policy.name)
                    .onTapGesture {
                        selection = policy.id
                    }
                    .if(selection == policy.id)
                    .listRowBackground(Color.accentColor)
                    .endif()
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct PolicyPicker_Previews: PreviewProvider {
    @State static var id = HistoryPolicy.default.id
    
    static var previews: some View {
        PolicyPicker(selection: $id)
    }
}
