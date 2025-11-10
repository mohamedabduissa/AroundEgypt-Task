//
//  Experience.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

// MARK: - Main Response Wrapper
struct ExperienceResponse: Codable {
    let data: [Experience]
}

// MARK: - Main Response Wrapper
struct SingleExperienceResponse: Codable {
    let data: Experience
}


// MARK: - Experience Model
struct Experience: Identifiable, Codable {
    let id: String?
    let title: String?
    let coverPhoto: String?
    let description: String?
    let viewsNo: Int?
    var likesNo: Int
    let recommended: Int?
    let address: String?
    var isLiked: Bool?
    let reviewsNo: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
        case address
        case isLiked = "is_liked"
        case reviewsNo = "reviews_no"
    }
    
}
