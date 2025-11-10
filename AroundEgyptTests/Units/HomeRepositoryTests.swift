//
//  HomeRepositoryTests.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//
import XCTest
@testable import AroundEgypt

final class HomeRepositoryTests: XCTestCase {
    var mockNetwork: MockNetwork!
    var mockCache: MockCache!
    var repository: HomeRepository!

    override func setUp() {
        mockNetwork = MockNetwork()
        mockCache = MockCache()
        repository = HomeRepository(networkManager: mockNetwork, cache: mockCache)
    }

    func test_fetchHomeData_savesAndLoadsFromCache() async throws {
        let exp = Experience.sample
        let response = ExperienceResponse(data: [exp])
        mockNetwork.responseData = try JSONEncoder().encode(response)

        let result = try await repository.fetchHomeData()
        XCTAssertEqual(result.recommended.first?.title, "Abu Simbel Temples")

        let cached: [Experience]? = mockCache.load([Experience].self, forKey: "experiences_cache")
        XCTAssertNotNil(cached)
        XCTAssertEqual(cached?.first?.id, exp.id)
    }

    func test_searchExperiences_online() async throws {
        let exp = Experience.sample
        let response = ExperienceResponse(data: [exp])
        mockNetwork.responseData = try JSONEncoder().encode(response)

        let results = await repository.searchExperiences(query: "Abu")
        XCTAssertEqual(results.first?.title, "Abu Simbel Temples")
    }

    func test_searchExperiences_offlineFallback() async throws {
        let exp = Experience.sample
        mockCache.save([exp], forKey: "experiences_cache")

        mockNetwork.shouldThrow = true
        let results = await repository.searchExperiences(query: "simbel")

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.title, "Abu Simbel Temples")
    }

    func test_likeExperience_updatesCache() async throws {
        var exp = Experience.sample
        mockCache.save([exp], forKey: "experiences_cache")

        exp.isLiked = true
        exp.likesNo = exp.likesNo + 1
        let updatedResponse = ExperienceResponse(data: [exp])
        mockNetwork.responseData = try JSONEncoder().encode(updatedResponse)

        let repo = ExperienceRepositoryMock(liked: exp)
        repository = HomeRepository(networkManager: mockNetwork, cache: mockCache, experienceRepo: repo)

        let updated = try await repository.likeExperience(Experience.sample)

        XCTAssertTrue(updated.isLiked ?? false)
        let cached: [Experience]? = mockCache.load([Experience].self, forKey: "experiences_cache")
        XCTAssertEqual(cached?.first?.likesNo, updated.likesNo)
    }
}

final class ExperienceRepositoryMock: ExperienceRepositoryProtocol {
    let liked: Experience
    init(liked: Experience) { self.liked = liked }

    func likeExperience(experience: Experience) async throws -> Experience {
        return liked
    }
}
