//
//  HeaderView.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Image("menu_icon")
                .padding(.leading, 12)

            HStack {
                Image("search_icon")
                
                TextField("Search", text: $viewModel.searchText)
                    .padding(.vertical, 8)
                    .onSubmit {
                        Task { await viewModel.searchExperiences() }
                    }

                if viewModel.isSearching {
                    Button(action: {
                        viewModel.clearSearch()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .accessibilityIdentifier("closeSearch")
                }
            }
            .padding(.horizontal, 10)
            .background(Color.lightGrayColor)
            .cornerRadius(12)
            .padding(.horizontal, 8)

            Image("filter_icon")
                .padding(.trailing, 12)
        }
        .padding(.vertical, 8)
    }
}
