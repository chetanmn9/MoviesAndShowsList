//
//  APIEndpoint.swift
//  ShowList

import Foundation

struct APIConfig {
    static let baseURL = "https://api.tvmaze.com"
}

enum APIEndpoint {
    case shows
    case showDetail(id: Int)
    case searchShows(query: String)

    var path: String {
        switch self {
        case .shows:
            return "/shows"
        case .showDetail(let id):
            return "/shows/\(id)"
        case .searchShows(let query):
            return "/search/shows?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }
    }

    var method: String {
        return "GET"
    }
}

extension APIEndpoint {
    var urlRequest: URLRequest? {
        guard let url = URL(string: APIConfig.baseURL + path) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        // Optionally add headers
        // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

