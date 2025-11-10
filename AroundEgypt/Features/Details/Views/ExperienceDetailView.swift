//
//  ExperienceDetailView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceDetailView: View {
    @Binding var experience: Experience?
    let onLike: (Experience) -> Void
    @Environment(\.dismiss) private var dismiss
    @State var showShareSheet = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                
                    ExperienceDetailsImageView(experience: experience, width: geo.size.width)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(experience?.title ?? "-")
                                    .font(FontsManager.font(for: .body, weight: .bold))
                                    .foregroundColor(Color.blackColor)
                                Text(experience?.address ?? "-")
                                    .font(FontsManager.font(for: .body, weight: .regular))
                                    .foregroundColor(Color.blackColor)
                            }

                            Spacer()

                            HStack(alignment: .center, spacing: 8) {
                                Button(action: {
                                    showShareSheet = true
                                }) {
                                    Image("share_icon")
                                }
                                .accessibilityIdentifier("shareButton")
                                
                                
                                Button(action: {
                                    if let experience {
                                        onLike(experience)
                                    }
                                }) {
                                    Image(experience?.isLiked == true ? "heart_icon" : "heart_empty_icon")
                                }

                                Text("\(experience?.likesNo ?? 0)")
                                    .font(FontsManager.font(for: .body, weight: .medium))
                                    .foregroundColor(Color.blackColor)
                            }
                        }
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)


                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description")
                            .font(FontsManager.font(for: .custom(size: 22), weight: .bold))
                            .foregroundColor(Color.blackColor)

                        Text(experience?.description ?? "-")
                            .font(FontsManager.font(for: .caption, weight: .medium))
                            .foregroundColor(Color.blackColor)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.backgroundColor)
            }
            .ignoresSafeArea(edges: .top)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(
                    items: [
                        shareMessage()
                    ]
                )
                .accessibilityIdentifier("ShareSheet")
            }
        }
    }
    
    func shareMessage() -> String {
        """
        \(experience?.title ?? "-")
        Address: \(experience?.address ?? "-")
        """
    }
}
