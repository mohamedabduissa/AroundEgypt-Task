//
//  LocalDataStore.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation
import Combine

final class LocalDataStore: ObservableObject {
    static let shared = LocalDataStore()

    @Published private(set) var experiences: [Experience] = []

    private let cacheKey = "experiences_cache"
    private let cache = CacheManager.shared

    private init() {
        loadFromDisk()
    }

    func saveAll(dataSource: [Experience]) {
        var dict = Dictionary(uniqueKeysWithValues: experiences.map { ($0.id, $0) })
        for exp in dataSource {
            dict[exp.id] = exp
        }
        experiences = Array(dict.values)
        saveToDisk()
    }

    func update(_ experience: Experience) {
        if let index = experiences.firstIndex(where: { $0.id == experience.id }) {
            experiences[index] = experience
        } else {
            experiences.append(experience)
        }
        saveToDisk()
    }

    func getAll() -> [Experience] {
        experiences
    }

    func get(by id: String) -> Experience? {
        experiences.first(where: { $0.id == id })
    }


    private func saveToDisk() {
        cache.save(experiences, forKey: cacheKey)
    }

    private func loadFromDisk() {
        if let cached: [Experience] = cache.load([Experience].self, forKey: cacheKey) {
            experiences = cached
        }
    }
}
