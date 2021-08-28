//
//  Ignored.swift
//  IntervalTimer
//
//  Created by Ostap on 27.08.2021.
//

import Foundation

@propertyWrapper
struct Ignored<Value>: Hashable, Encodable {
    var wrappedValue: Value
    
    func encode(to encoder: Encoder) throws {}
    
    func hash(into hasher: inout Hasher) {}
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
