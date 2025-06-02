//
//  ShowsViewModel.swift
//  ShowList

import Foundation

class ShowViewModel: ObservableObject {
    @Published var shows: [Show] = []
    @Published var filteredShows: [Show] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    @MainActor
    func fetchData(from endpoint: APIEndpoint) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let shows = try await networkService.fetch([Show].self, from: endpoint)
            self.shows = shows
            self.filteredShows = shows
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func filterShows(query: String) {
        if query.isEmpty {
            filteredShows = shows
        } else {
            filteredShows = shows.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}
