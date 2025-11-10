//
//  OverlayImageCardView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import SwiftUI

struct OverlayImageCardView: View {
    let experience: Experience

    var body: some View {
        ZStack {
            Image("360_icon")

            // Check Recommended
            if experience.recommended == 1 {
                VStack {
                    HStack {
                        HStack {
                            Image("favorite_icon")
                            
                            Text("RECOMMENDED")
                                .font(FontsManager.font(for: .custom(size: 10), weight: .bold))
                                
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blackColor.opacity(0.5))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding([.top, .leading], 8)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Image("info_icon")
                        .padding(8)
                }
                
                Spacer()
                
                HStack {
                    Image("eye_icon")
                    Text("\(experience.viewsNo ?? 0)")
                        .font(FontsManager.font(for: .caption, weight: .medium))
                        .foregroundColor(Color.whiteColor)
                    
                    Spacer()
                    
                    Image("images_icon")

                }
                .padding(8)
                
            }
        }
    }
}
