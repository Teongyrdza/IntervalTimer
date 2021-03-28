//
//  Sound.swift
//  IntervalTimer
//
//  Created by Ostap on 17.03.2021.
//

import AVFoundation

extension AVPlayer {
    static let meditationPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "meditationBell", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    static let dingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}

enum Sound: String, CaseIterable, CustomStringConvertible {
    case ding = "Ding"
    case meditationBell = "Meditation Bell"
    
    var description: String {
        self.rawValue
    }
    
    var player: AVPlayer {
        switch self {
            case .ding:
                return .dingPlayer
            case .meditationBell:
                return .meditationPlayer
        }
    }
}
