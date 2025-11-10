//
//  ExperienceCardView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceCardView: View {
    let experience: Experience
    let onTap: () -> Void
    let onLike: () -> Void
    
    var body: some View {
        VStack {
            KFImage(URL(string: experience.coverPhoto ?? ""))
                .placeholder {
                    Rectangle()
                        .fill(Color(.systemGray5))
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 155)
                .frame(maxWidth: .infinity)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    OverlayImageCardView(experience: experience)
                        .frame(maxWidth: .infinity)
                )
                .accessibilityIdentifier("image")
                .onTapGesture {
                    onTap()
                }
            
            
            VStack {
                HStack(alignment: .top) {
                    Text(experience.title ?? "-")
                        .font(FontsManager.font(for: .body, weight: .bold))
                        .foregroundColor(Color.blackColor)
                    Spacer()
                    Button(action: onLike) {
                        HStack {
                            Text("\(experience.likesNo)")
                                .font(FontsManager.font(for: .caption, weight: .regular))
                                .foregroundColor(Color.blackColor)
                            
                            Image(experience.isLiked == true ? "heart_icon" : "heart_empty_icon")
                        }
                    }
                }
                .padding(.vertical, 8)

            }
        }
    }
}
