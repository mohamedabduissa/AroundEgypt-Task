//
//  HomeView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(viewModel: viewModel)
            
            ScrollView(showsIndicators: false) {
                // Search Section
                if viewModel.isSearching {
                    if viewModel.searchResults.isEmpty {
                        Text("No results found")
                            .font(FontsManager.font(for: .custom(size: 22), weight: .bold))
                            .foregroundColor(Color.blackColor)
                            .padding(.top, 40)
                    } else {
                        SearchResultsView(results: viewModel.searchResults, onTap: { experience in
                            viewModel.showDetail = true
                            viewModel.selectedExperience = experience
                        }, onLike: { experience in
                            Task {
                                await viewModel.likeExperience(experience)
                            }
                        })
                    }
                } else {
                    // Default Section
                    HomeContentView(viewModel: viewModel)
                }
            }
            .animation(.default, value: viewModel.isSearching)
            .background(Color.backgroundColor)
            .task {
                await viewModel.loadHome()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $viewModel.showDetail) {
            ExperienceDetailView(experience: $viewModel.selectedExperience) { experience in
                Task {
                    if let updatedExperience = await viewModel.likeExperience(experience) {
                        viewModel.selectedExperience = updatedExperience
                    }
                }
            }
        }
    }
}

