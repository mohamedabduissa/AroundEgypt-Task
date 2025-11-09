//
//  APIRequest.swift
//  AroundEgypt
//
//  Created by MacbookPro on 09/11/2025.
//

import Foundation

// MARK: - APIRequest Protocol
protocol APIRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
    var encodableBody: Encodable? { get }
}

// MARK: - Default Implementations
extension APIRequest {
    var baseURL: String { Bundle.main.infoDictionary?["BASE URL"] as? String ?? "" }
    var headers: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    var queryParameters: [String: String]? { nil }
    var encodableBody: Encodable? { nil }

    func buildURLRequest() throws -> URLRequest {
        var urlString = baseURL + path
        if let query = queryParameters, !query.isEmpty {
            let queryItems = query.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString += "?\(queryItems)"
        }

        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let body = encodableBody?.asJSONData() {
            request.httpBody = body
        }

        return request
    }
}
