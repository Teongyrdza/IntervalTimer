//
//  SoundPicker.swift
//  IntervalTimer
//
//  Created by Ostap on 30.03.2021.
//

import SwiftUI
import AVFoundation

struct SoundPicker: View {
    @Binding var selection: Sound
    @State private var isPlaying = false
    
    private var player: AVPlayer {
        selection.player
    }
    
    var body: some View {
        List {
            ForEach(Sound.allCases, id: \.self) { sound in
                Text(sound.description)
                    .onTapGesture {
                        // Stop previous sound, if playing
                        if isPlaying {
                            isPlaying = false
                            player.pause()
                        }
                        
                        if selection != sound || !isPlaying {
                            selection = sound
                            isPlaying = true
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#if DEBUG
struct SoundPicker_Previews: PreviewProvider {
    @State static var sound: Sound = .meditationBell
    
    static var previews: some View {
        SoundPicker(selection: $sound)
    }
}
#endif
