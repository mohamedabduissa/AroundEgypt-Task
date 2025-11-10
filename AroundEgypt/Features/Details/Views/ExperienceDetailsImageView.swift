//
//  ExperienceDetailsImageView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceDetailsImageView: View {
    let experience: Experience?
    let width: CGFloat
    
    init(experience: Experience?, width: CGFloat = .infinity) {
        self.experience = experience
        self.width = width
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            KFImage(URL(string: experience?.coverPhoto ?? ""))
                .placeholder {
                    Rectangle().fill(Color.gray)
                }
                .resizable()
                .scaledToFill()
                .frame(height: 285)
                .frame(maxWidth: width)
                .clipped()
                .overlay {
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.6), .black.opacity(0.2), Color .clear]),
                            startPoint: .bottom,
                            endPoint: .center
                        )
                        VStack {
                            Spacer()
                            HStack(spacing: 6) {
                                Image("eye_icon")
                                Text("\(experience?.viewsNo ?? 0) views")
                                    .font(FontsManager.font(for: .caption, weight: .medium))
                                    .foregroundColor(Color.whiteColor)
                                Spacer()
                                Image("images_icon")
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 20)
                        }
                    }
                }


            VStack(spacing: 10) {
                Button(action: {
                    // Action
                }) {
                    Text("EXPLORE NOW")
                        .font(FontsManager.font(for: .caption, weight: .bold))
                        .foregroundColor(Color.orangeColor)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 15)
                        .background(Color.whiteColor)
                        .cornerRadius(8)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}
