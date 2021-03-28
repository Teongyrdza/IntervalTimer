//
//  RoundedButtonStyle.swift
//  IntervalTimer
//
//  Created by Ostap on 06.01.2021.
//

import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    let lineWidth: CGFloat
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .foregroundColor(.accentColor)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.accentColor, lineWidth: lineWidth)
        }
    }
}

#if DEBUG
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Press Me", action: {})
            .buttonStyle(RoundedButtonStyle(lineWidth: 5, cornerRadius: 10))
            .accentColor(.purple)
            .frame(width: 75, height: 50)
    }
}
#endif
