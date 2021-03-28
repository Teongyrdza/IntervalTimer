//
//  ProgressCircle.swift
//  IntervalTimer (iOS)
//
//  Created by Ostap on 28.12.2020.
//

import SwiftUI

struct Ring: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    let thickness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let h = min(rect.height, rect.width)
        let c = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        
        path.addArc(
            center: c,
            radius: h / 2,
            startAngle: .degrees(startAngle.degrees - 90),
            endAngle: .degrees(endAngle.degrees - 90),
            clockwise: clockwise
        )
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round, lineJoin: .round))
    }
}

// MARK: - Progress Circle
struct CircularProgressViewStyle: ProgressViewStyle {
    var thickness: CGFloat = 10
    
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Spacer()
            
            configuration.label
            
            ZStack {
                // Background circle
                Ring(startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false, thickness: thickness)
                    .fill(Color.backgroundColor)
                
                // Progress ring
                Ring(startAngle: .degrees(0), endAngle: .degrees(360 * (configuration.fractionCompleted ?? 0)), clockwise: false, thickness: thickness)
                    .fill(Color.accentColor)
            }
            
            Spacer()
        }
    }
}

#if DEBUG
struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView("Progress Circle", value: 75, total: 100)
            .progressViewStyle(CircularProgressViewStyle(thickness: 30))
            .padding()
    }
}
#endif

// MARK: - Progress Circle styling

extension Color {
    static var backgroundColor: Color = .gray
}

extension View {
    func backgroundColor(_ backgroundColor: Color) {
        Color.backgroundColor = backgroundColor
    }
}
