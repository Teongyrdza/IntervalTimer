//
//  Environment.swift
//  IntervalTimer
//
//  Created by Ostap on 08.01.2021.
//

import SwiftUI

struct TimerShowingKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var timerShowing: Binding<Bool> {
        get { return self[TimerShowingKey] }
        set { self[TimerShowingKey] = newValue }
    }
}
