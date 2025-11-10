//
//  NetworkError.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(Int)
    case unknown(Error)
    case error(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid server response"
        case .decodingFailed: return "Failed to decode data"
        case .serverError(let code): return "Server returned error: \(code)"
        case .unknown(let err): return err.localizedDescription
        case .error(let err): return err
        }
    }
}
