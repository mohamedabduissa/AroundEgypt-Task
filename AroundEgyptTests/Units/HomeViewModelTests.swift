//
//  HomeViewModelTests.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import XCTest
@testable import AroundEgypt

@MainActor
final class HomeViewModelTests: XCTestCase {
    var repo: MockHomeRepository!
    var viewModel: HomeViewModel!

    override func setUp() {
        repo = MockHomeRepository()
        viewModel = HomeViewModel(repository: repo)
    }

    func test_loadHome_populatesData() async {
        repo.recommended = [Experience.sample]
        repo.recent = [Experience.sample]
        await viewModel.loadHome()

        XCTAssertEqual(viewModel.recommended.first?.title, "Abu Simbel Temples")
        XCTAssertEqual(viewModel.recent.first?.id, "7f209d18-36a1-44d5-a0ed-b7eddfad48d6")
    }

    func test_searchExperiences_setsState() async {
        repo.searchResults = [Experience.sample]
        viewModel.searchText = "Abu"
        await viewModel.searchExperiences()

        XCTAssertTrue(viewModel.isSearching)
        XCTAssertEqual(viewModel.searchResults.first?.title, "Abu Simbel Temples")
    }

    func test_clearSearch_resetsValues() {
        viewModel.isSearching = true
        viewModel.searchText = "abc"
        viewModel.searchResults = [Experience.sample]

        viewModel.clearSearch()

        XCTAssertFalse(viewModel.isSearching)
        XCTAssertTrue(viewModel.searchResults.isEmpty)
        XCTAssertEqual(viewModel.searchText, "")
    }

    func test_likeExperience_updatesItems() async {
        let exp = Experience.sample
        repo.likedExp = {
            var e = exp
            e.isLiked = true
            e.likesNo = 9999
            return e
        }()

        viewModel.recommended = [exp]
        viewModel.recent = [exp]
        let updated = await viewModel.likeExperience(exp)

        XCTAssertEqual(updated?.likesNo, 9999)
        XCTAssertTrue(viewModel.recommended.first?.isLiked ?? false)
    }
}

final class MockHomeRepository: HomeRepositoryProtocol {
    var recommended: [Experience] = []
    var recent: [Experience] = []
    var searchResults: [Experience] = []
    var likedExp: Experience?

    func fetchHomeData() async throws -> (recommended: [Experience], recent: [Experience]) {
        return (recommended, recent)
    }

    func searchExperiences(query: String) async -> [Experience] {
        return searchResults
    }

    func likeExperience(_ experience: Experience) async throws -> Experience {
        return likedExp ?? experience
    }
}
