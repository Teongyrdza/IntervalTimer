//
//  Dict->Array.swift
//  IntervalTimer
//
//  Created by Ostap on 26.08.2021.
//

import Foundation
import OrderedCollections

extension Dictionary {
    func toArray() -> [Value] {
        Array(values)
    }
}

extension OrderedDictionary {
    func toArray() -> [Value] {
        Array(values)
    }
}
