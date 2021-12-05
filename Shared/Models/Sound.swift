//
//  Sound.swift
//  IntervalTimer
//
//  Created by Ostap on 17.03.2021.
//

import AVFoundation
import SoundKit

extension AVAudioPlayer {
    convenience init(named name: String, withExtension `extension`: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: `extension`) else { fatalError("Failed to find sound file.") }
        try! self.init(contentsOf: url)
    }
    
    static let meditationBell = AVAudioPlayer(named: "meditationBell")
    
    static let ding = AVAudioPlayer(named: "ding")
}

let sounds = [
    BuiltinSound(name: "Ding", fileName: "ding.mp3"),
    BuiltinSound(name: "Meditation Bell", fileName: "meditationBell.mp3")
]

extension SoundStore: DefaultConstructible {}

extension SoundStore {
    private static let url = DataStore.soundsUrl
    
    static func load() -> Self {
        DataStore.load(Self.self, from: url)
    }
    
    func save() {
        DataStore.save(self, to: Self.url)
    }
}
