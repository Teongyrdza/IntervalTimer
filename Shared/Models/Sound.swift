//
//  Sound.swift
//  IntervalTimer
//
//  Created by Ostap on 17.03.2021.
//

import AVFoundation
import SoundKit
import ItDepends

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
    BuiltinSound(name: "Meditation bell", fileName: "meditationBell.mp3")
]

extension SoundStore: JSONModel {
    public static let url = FileManager.documentsFolder.appendingPathComponent("sounds.json")
}
