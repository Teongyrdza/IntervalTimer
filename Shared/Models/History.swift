//
//  History.swift
//  IntervalTimer
//
//  Created by Ostap on 24.08.2021.
//

import Foundation
import SwiftUI

struct History: Hashable, Codable, Identifiable {
    static let formatter = { () -> DateFormatter in
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    }()
    
    var id = UUID()
    var name: String
    var task: Task?
    var date = Date()
    var duration: TimeInterval
    var cycleDuration: TimeInterval
    
    var cycles: Int {
        Int(duration / cycleDuration)
    }
    
    var dateString: String {
        Self.formatter.string(from: date)
    }
    
    var color: Color? {
        if let recommendedDuration = task?.recommendedDuration {
            if duration <= recommendedDuration {
                return .green
            }
            else {
                return .red
            }
        }
        return nil
    }
}

extension History {
    init(name: String, cycles: Int, duration: TimeInterval) {
        self.name = name
        self.cycleDuration = duration / Double(cycles)
        self.duration = duration
    }
    
    static let exampleData: [Self] = [
        .init(name: "Розстелити ліжко", cycles: 10, duration: 150),
        .init(name: "Зарядка", cycles: 5, duration: 80),
        .init(name: "Чистити зуби", cycles: 3, duration: 90),
        .init(name: "Застелити ліжко", cycles: 20, duration: 300)
    ]
}
