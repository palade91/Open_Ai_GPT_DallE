//
//  UserDefaultsUseCase.swift
//  GPT
//
//  Created by Catalin Palade on 28/03/2023.
//

import Foundation

class UserDefaultsUseCase {
    
    static let shared: UserDefaultsUseCase = UserDefaultsUseCase()
    
    private let defaults = UserDefaults.standard
    
    private init() { }
    
    func set<T: Codable>(object: T, forKey key: String) throws {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            defaults.set(data, forKey: key)
        } catch {
            throw UserDefaultsError.unableToEncode
        }
    }
    
    func get<T: Codable>(forKey key: String, castTo type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        guard let data = defaults.object(forKey: key) as? Data else {
            throw UserDefaultsError.unableToGetData
        }
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw UserDefaultsError.unableToDecode
        }
    }
    
    func clearAll(forKey key: String) {
        defaults.set([], forKey: key)
    }
}

enum UserDefaultsError: String, LocalizedError {
    case unableToEncode = "Unable to encode object into data"
    case unableToDecode = "Unable to decode object into given type"
    case unableToGetData = "Unable to get data from UserDefaults"
    
    var errorDescription: String {
        rawValue
    }
}
