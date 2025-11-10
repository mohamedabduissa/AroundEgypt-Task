//
//  APIEndpoints.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

enum APIEndpoints: APIRequest {
    case recommendedExperiences
    case recentExperiences
    case searchExperiences(String)
    case singleExperience(String)
    case likeExperience(String)
    
    var path: String {
        switch self {
        case .recommendedExperiences:
            return "experiences?filter[recommended]=true"
        case .recentExperiences:
            return "experiences"
        case .searchExperiences(let text):
            return "experiences?filter[title]=\(text)"
        case .singleExperience(let experienceID):
            return "experiences/\(experienceID)"
        case .likeExperience(let experienceID):
            return "experiences/\(experienceID)/like"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .recommendedExperiences:
            return .GET
        case .recentExperiences:
            return .GET
        case .searchExperiences:
            return .GET
        case .singleExperience:
            return .GET
        case .likeExperience:
            return .POST
        }
    }
}
