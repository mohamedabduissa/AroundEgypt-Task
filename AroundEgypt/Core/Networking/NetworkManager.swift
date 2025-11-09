//
//  NetworkManager.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared

    private init() {}

    func send<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        let urlRequest = try request.buildURLRequest()

        let (data, response) = try await session.data(for: urlRequest)
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw NetworkError.serverError(http.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
