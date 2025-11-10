//
//  HomeRepository.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

protocol HomeRepositoryProtocol {
    func fetchHomeData() async throws -> (recommended: [Experience], recent: [Experience])
    func searchExperiences(query: String) async -> [Experience]
    func likeExperience(_ experience: Experience) async throws -> Experience
}

final class HomeRepository: HomeRepositoryProtocol {
    private let networkManager: NetworkManaging
    private let cache: CacheManaging
    private let experienceRepo: ExperienceRepositoryProtocol
    
    private let cacheKey = "experiences_cache"
    
    init(
        networkManager: NetworkManaging = NetworkManager.shared,
        cache: CacheManaging = CacheManager.shared,
        experienceRepo: ExperienceRepositoryProtocol = ExperienceRepository.shared
    ) {
        self.networkManager = networkManager
        self.cache = cache
        self.experienceRepo = experienceRepo
    }
    
    func fetchHomeData() async throws -> (recommended: [Experience], recent: [Experience]) {
        // load from cache
        if let cached = cache.load([Experience].self, forKey: cacheKey) {
            let recommended = cached.filter { $0.recommended == 1 }
            let recent = cached.sorted(by: { ($0.viewsNo ?? 0) > ($1.viewsNo ?? 0) })
            return (recommended, recent)
        }
        
        // load from server if cache not available
        async let recommendedList = try networkManager.send(
            APIEndpoints.recommendedExperiences,
            as: ExperienceResponse.self
        )
        async let recentList = try networkManager.send(
            APIEndpoints.recentExperiences,
            as: ExperienceResponse.self
        )
        
        let (recommended, recent) = try await (recommendedList.data, recentList.data)
        

        // merge all data
        let combined = Array(
            Dictionary(
                (recommended + recent).compactMap { exp in
                    exp.id.map { ($0, exp) }
                },
                uniquingKeysWith: { first, _ in first }
            ).values
        )
        cache.save(combined, forKey: cacheKey)
        
        return (recommended, recent)
    }
    
    // MARK: - Search Experiences
    func searchExperiences(query: String) async -> [Experience] {
        // try online
        do {
            let request = APIEndpoints.searchExperiences(query)
            let response: ExperienceResponse = try await networkManager.send(request, as: ExperienceResponse.self)
            return response.data
        } catch {
            print("⚠️ Search failed online, fallback to cached data. Error: \(error.localizedDescription)")
            // search offline
            guard let cached: [Experience] = cache.load([Experience].self, forKey: cacheKey) else {
                return []
            }

            // case-insensitive search
            let lowerQuery = query.lowercased()
            return cached.filter { $0.title?.lowercased().contains(lowerQuery) == true }
        }
    }

    
    func likeExperience(_ experience: Experience) async throws -> Experience {
        let updated = try await experienceRepo.likeExperience(experience: experience)
        
        // update cache local
        if var cached = cache.load([Experience].self, forKey: cacheKey),
           let index = cached.firstIndex(where: { $0.id == updated.id }) {
            cached[index] = updated
            cache.save(cached, forKey: cacheKey)
        }
        
        return updated
    }
}
