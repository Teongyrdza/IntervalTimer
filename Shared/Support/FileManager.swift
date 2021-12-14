//
//  FileManager.swift
//  IntervalTimer
//
//  Created by Ostap on 12.12.2021.
//

import Foundation

extension FileManager {
    static let documentsFolder: URL = {
        do {
            return try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
        }
        catch {
            fatalError("Cannot find documents folder")
        }
    }()
}
