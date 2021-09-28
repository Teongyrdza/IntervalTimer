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
    @State var playing = false
    
    var player: AVPlayer {
        selection.player
    }
    
    var body: some View {
        List {
            ForEach(sounds) { sound in
                Text(sound.description)
                    .onTapGesture {
                        // Stop previous sound, if playing
                        if playing {
                            playing = false
                            player.pause()
                        }
                        
                        if selection != sound || !playing {
                            selection = sound
                            playing = true
                            player.seek(to: .zero)
                            player.play()
                        }
                    }
                    .if(selection == sound)
                    .listRowBackground(Color.accentColor)
                    .endif()
            }
        }
        .listStyle(.grouped)
    }
}

#if DEBUG
struct SoundPicker_Previews: PreviewProvider {
    @State static var sound: Sound = sounds[0]
    
    static var previews: some View {
        SoundPicker(selection: $sound)
    }
}
#endif
