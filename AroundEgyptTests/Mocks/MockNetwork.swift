//
//  MockNetwork.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import Foundation
@testable import AroundEgypt

final class MockNetwork: NetworkManaging {
    var responseData: Data?
    var shouldThrow = false
    var lastRequest: APIRequest?

    func send<T>(_ request: APIRequest, as type: T.Type) async throws -> T where T : Decodable {
        lastRequest = request

        if shouldThrow {
            throw NetworkError.invalidURL
        }

        guard let data = responseData else {
            throw NetworkError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
