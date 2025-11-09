//
//  CacheManager.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()

    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    private init() {
        let base = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = base.appendingPathComponent("AroundEgyptCache", isDirectory: true)

        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }

    private func fileURL(for key: String) -> URL {
        cacheDirectory.appendingPathComponent("\(key).json")
    }

    func save<T: Encodable>(_ object: T, forKey key: String) {
        let url = fileURL(for: key)
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Cache Save Error:", error.localizedDescription)
        }
    }

    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        let url = fileURL(for: key)
        guard fileManager.fileExists(atPath: url.path) else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Cache Load Error:", error.localizedDescription)
            return nil
        }
    }

    func remove(forKey key: String) {
        let url = fileURL(for: key)
        try? fileManager.removeItem(at: url)
    }

    func clearAll() {
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
}
