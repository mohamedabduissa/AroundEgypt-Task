//
//  HomeViewModel.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var recommended: [Experience] = []
    @Published var recent: [Experience] = []
    @Published var searchResults: [Experience] = []
    @Published var selectedExperience: Experience?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var showDetail = false


    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func loadHome() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let data = try await repository.fetchHomeData()
            recommended = data.recommended
            recent = data.recent
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @discardableResult
    func likeExperience(_ experience: Experience) async -> Experience? {
        if experience.isLiked == true { return nil }
        do {
            let updated = try await repository.likeExperience(experience)
            if let i = recommended.firstIndex(where: { $0.id == experience.id }) {
                recommended[i] = updated
            }
            if let i = recent.firstIndex(where: { $0.id == experience.id }) {
                recent[i] = updated
            }
            if let i = searchResults.firstIndex(where: { $0.id == experience.id }) {
                searchResults[i] = updated
            }
            return updated
        } catch {
            errorMessage = error.localizedDescription
        }
        return nil
    }
    func searchExperiences() async {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            searchResults = []
            isSearching = false
            return
        }
        isSearching = true
        searchResults = await repository.searchExperiences(query: searchText)
    }

    func clearSearch() {
        searchText = ""
        searchResults = []
        isSearching = false
    }

}
