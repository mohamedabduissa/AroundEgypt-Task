//
//  HomeContentView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//
import SwiftUI

struct HomeContentView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // Welcome Section
            VStack(alignment: .leading, spacing: 6) {
                Text("Welcome!")
                    .font(FontsManager.font(for: .custom(size: 22), weight: .bold))
                    .foregroundColor(Color.blackColor)

                Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                    .font(FontsManager.font(for: .caption, weight: .medium))
                    .foregroundColor(Color.blackColor)
                    .lineSpacing(3)
            }
            .padding(.horizontal)
            .padding(.top, 10)

            // Recommended Section
            if !viewModel.recommended.isEmpty {
                Text("Recommended Experiences")
                    .font(FontsManager.font(for: .custom(size: 22), weight: .bold))
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.recommended) { experience in
                            ExperienceCardView(
                                experience: experience,
                                onTap: {
                                viewModel.showDetail = true
                                viewModel.selectedExperience = experience
                            }, onLike: {
                                Task {
                                    await viewModel.likeExperience(experience)
                                }
                            })
                        }
                    }
                    .padding(.horizontal)
                }
            }

            // Most Recent Section
            if !viewModel.recent.isEmpty {
                Text("Most Recent")
                    .font(FontsManager.font(for: .custom(size: 22), weight: .bold))
                    .padding(.horizontal)
                    .padding(.top, 10)

                VStack(spacing: 18) {
                    ForEach(viewModel.recent) { experience in
                        ExperienceCardView(
                            experience: experience,
                            onTap: {
                            viewModel.showDetail = true
                            viewModel.selectedExperience = experience
                        }, onLike: {
                            Task {
                                await viewModel.likeExperience(experience)
                            }
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
        .padding(.bottom, 40)
    }
}
