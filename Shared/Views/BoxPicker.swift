//
//  BoxPicker.swift
//  IntervalTimer
//
//  Created by Ostap on 24.12.2021.
//

import SwiftUI
import SoundKit
import ItDepends

struct BoxPicker<Content: View>: View {
    let title: LocalizedStringKey
    let label: String
    let content: () -> Content
    
    var body: some View {
        GroupBox {
            HStack {
                Text(title)
                
                Spacer()
                
                NavigationLink(destination: content) {
                    Text(label)
                        .opacity(0.5)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    init(_ title: LocalizedStringKey, label: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.label = label
        self.content = content
    }
}

#if DEBUG
struct BoxPicker_Previews: PreviewProvider {
    @StateObject static var settings = TimerSettings().withDependencies(from: ModelStore.default())
    
    static var previews: some View {
        NavigationView {
            VStack {
                BoxPicker("Sound", label: settings.sound.name) {
                    SoundPicker(selection: $settings.sound, builtinSounds: sounds)
                        .listStyle(.grouped)
                        .navigationTitle("Sound")
                }
                
                BoxPicker("Task", label: settings.currentTask.name) {
                    TaskPicker(store: .init(), selection: $settings.currentTaskId)
                        .navigationTitle("Task")
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}
#endif
