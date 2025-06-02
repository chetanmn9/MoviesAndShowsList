//
//  NetworkService.swift
//  ShowList

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from endpoint: APIEndpoint) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from endpoint: APIEndpoint) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
