//
//  MockCache.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import Foundation
@testable import AroundEgypt

final class MockCache: CacheManaging {
    private var storage: [String: Data] = [:]

    func save<T>(_ object: T, forKey key: String) where T : Encodable {
        storage[key] = try? JSONEncoder().encode(object)
    }

    func load<T>(_ type: T.Type, forKey key: String) -> T? where T : Decodable {
        guard let data = storage[key] else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    func remove(forKey key: String) { storage.removeValue(forKey: key) }
    func clearAll() { storage.removeAll() }
}
