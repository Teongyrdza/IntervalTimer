//
//  String.swift
//  IntervalTimer
//
//  Created by Ostap on 05.05.2021.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: CVarArg, specifier: String) {
        appendInterpolation(String(format: specifier, value))
    }
}
