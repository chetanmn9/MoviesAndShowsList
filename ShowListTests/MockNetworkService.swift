//
//  MockNetworkService.swift
//  ShowList


import XCTest
@testable import ShowList

final class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: [Show] = []

    func fetch<T: Decodable>(_ type: T.Type, from endpoint: APIEndpoint) async throws -> T {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
                
        guard let shows = mockData as? T else {
            fatalError("Mocked data type mismatch")
        }
        return shows
    }
}
