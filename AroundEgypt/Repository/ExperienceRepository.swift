//
//  ExperienceRepository.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//
//
import Foundation

protocol ExperienceRepositoryProtocol {
    func likeExperience(experience: Experience) async throws -> Experience
}

final class ExperienceRepository: ExperienceRepositoryProtocol {
    static let shared = ExperienceRepository()
    private let network: NetworkManaging
    private let cache: CacheManaging
    private let cacheKey = "experiences_cache"
    
    init(network: NetworkManaging = NetworkManager.shared,
         cache: CacheManaging = CacheManager.shared) {
        self.network = network
        self.cache = cache
    }
    
    func likeExperience(experience: Experience) async throws -> Experience {
        guard let id = experience.id else {
            throw NetworkError.error("The id is missing")
        }
        
        let _ = try await network.send(APIEndpoints.likeExperience(id), as: EmptyCodable.self)
                 
        var updatedExperience = experience
        updatedExperience.isLiked = true
        updatedExperience.likesNo += 1
        
        if var cached = cache.load([Experience].self, forKey: cacheKey) {
            if let idx = cached.firstIndex(where: { $0.id == id }) {
                cached[idx] = updatedExperience
            } else {
                cached.append(updatedExperience)
            }
            cache.save(cached, forKey: cacheKey)
        } else {
            cache.save([updatedExperience], forKey: cacheKey)
        }
        
        return updatedExperience
    }
}
