//
//  TimerSettings.swift
//  IntervalTimer
//
//  Created by Ostap on 07.01.2021.
//

import AVFoundation
import Foundation
import Combine

final class TimerSettings: ObservableObject {
    @Published var interval: TimeInterval = 30
    @Published var sound: Sound = sounds[1]
}
