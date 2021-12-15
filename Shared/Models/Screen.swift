//
//  Screen.swift
//  IntervalTimer
//
//  Created by Ostap on 15.12.2021.
//

import SwiftUI
import ItDepends

struct Screen: Identifiable {
    let id = UUID()
    let label: LocalizedStringKey
    let icon: String?
    let content: (ModelStore) -> AnyView

    init<Content: View>(_ label: LocalizedStringKey, icon: String? = nil, content: @escaping () -> Content) {
        self.init(label, icon: icon) { _ in
            content()
        }
    }
    
    init<Content: View>(_ label: LocalizedStringKey, icon: String? = nil, content: @escaping (ModelStore) -> Content) {
        self.label = label
        self.icon = icon
        self.content = { modelStore in
            AnyView(content(modelStore))
        }
    }

    init<Content: View & Depender>(_ label: LocalizedStringKey, icon: String? = nil, content: @escaping () -> Content) {
        self.init(label, icon: icon) { modelStore in
            content().withDependencies(from: modelStore)
        }
    }
}
