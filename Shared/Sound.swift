//
//  Sound.swift
//  IntervalTimer
//
//  Created by Ostap on 17.03.2021.
//

import AVFoundation

extension AVPlayer {
    convenience init(named name: String, withExtension `extension`: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: `extension`) else { fatalError("Failed to find sound file.") }
        self.init(url: url)
    }
    
    static let meditationPlayer = AVPlayer(named: "meditationBell")
    
    static let dingPlayer = AVPlayer(named: "ding")
}

struct Sound: Hashable, Identifiable, CustomStringConvertible {
    let id = UUID()
    let name: String
    let description: String
    let player: AVPlayer
    
    static func == (lhs: Sound, rhs: Sound) -> Bool {
        lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    init(named name: String, description: String) {
        self.name = name
        self.description = description
        
        player = .init(named: name)
    }
}

let sounds = [
    Sound(named: "ding", description: "Ding"),
    Sound(named: "meditationBell", description: "Meditation Bell")
]
