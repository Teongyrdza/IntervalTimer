//
//  DataStore.swift
//  IntervalTimer
//
//  Created by Ostap on 27.08.2021.
//

import Foundation

protocol DefaultConstructible {
    init()
}

enum DataStore {
    static var documentsFolder: URL = {
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
    
    static var settingsURL: URL {
        print(documentsFolder)
        return documentsFolder.appendingPathComponent("settings.json")
    }
    
    static var historyUrl = documentsFolder.appendingPathComponent("history.json")
    
    static var tasksUrl = documentsFolder.appendingPathComponent("tasks.json")
    
    static func load<T: Decodable & DefaultConstructible>(_ type: T.Type, from url: URL) -> T {
        guard let data = try? Data(contentsOf: url) else {
            print("Data loading failed")
            return .init()
        }
        
        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            print("Can't decode saved data.")
            return .init()
        }
        
        return decoded
    }
    
    static func save<T: Encodable>(_ object: T, to url: URL) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? JSONEncoder().encode(object) else { fatalError("Error encoding data") }
            
            do {
                try data.write(to: url)
            }
            catch {
                fatalError("Can't write data to file")
            }
        }
    }
}
