//
//  Localized.swift
//  IntervalTimer
//
//  Created by Ostap on 25.10.2021.
//

import Foundation
import SwiftUI

extension String {
    func localized() -> LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
