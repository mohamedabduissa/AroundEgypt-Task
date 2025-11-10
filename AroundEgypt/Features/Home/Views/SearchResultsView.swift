//
//  SearchResultsView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import SwiftUI

struct SearchResultsView: View {
    let results: [Experience]
    let onTap: (Experience) -> Void
    let onLike: (Experience) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(results) { experience in
                ExperienceCardView(
                    experience: experience,
                    onTap: {
                    onTap(experience)
                }, onLike: {
                    onLike(experience)
                })
            }
        }
        .padding(.horizontal)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .animation(.easeInOut(duration: 0.25), value: results.count)
       
    }
}
