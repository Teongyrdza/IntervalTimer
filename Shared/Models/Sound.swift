//
//  Sound.swift
//  IntervalTimer
//
//  Created by Ostap on 17.03.2021.
//

import AVFoundation
import Reactor

extension AVPlayer {
    convenience init(named name: String, withExtension `extension`: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: `extension`) else { fatalError("Failed to find sound file.") }
        self.init(url: url)
    }
    
    static let meditationPlayer = AVPlayer(named: "meditationBell")
    
    static let dingPlayer = AVPlayer(named: "ding")
}

struct Sound: Hashable, Encodable, Identifiable, CustomStringConvertible {
    var id = UUID()
    let name: String
    let description: String
    @Ignored var player: AVPlayer
    
    static func == (lhs: Sound, rhs: Sound) -> Bool {
        lhs.name == rhs.name && lhs.description == rhs.description
    }
    
    init(named name: String, description: String) {
        self.name = name
        self.description = description
        
        player = .init(named: name)
    }
}

extension Sound: Decodable {
    enum CodingKeys: CodingKey {
        case id, name, description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        player = .init(named: name)
    }
}

let sounds = [
    Sound(named: "ding", description: "Ding"),
    Sound(named: "meditationBell", description: "Meditation Bell")
]
