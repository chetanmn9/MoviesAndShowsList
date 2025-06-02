//
//  ShowListTests.swift
//  ShowListTests


import Testing
import XCTest
@testable import ShowList

@MainActor
final class ShowViewModelTests: XCTestCase {

    func testFetchData_SuccessfulResponse_UpdatesShows() async {
        let mockService = MockNetworkService()
        mockService.mockData = [Show.mock(id: 1, name: "Test Show")]

        let viewModel = ShowViewModel(networkService: mockService)

        await viewModel.fetchData(from: .shows)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.shows.count, 1)
        XCTAssertEqual(viewModel.shows.first?.name, "Test Show")
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchData_ErrorResponse_SetsErrorMessage() async {
        let mockService = MockNetworkService()
        mockService.shouldReturnError = true

        let viewModel = ShowViewModel(networkService: mockService)

        await viewModel.fetchData(from: .shows)

        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.shows.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
    }

    func testFilterShows_WithQuery_FiltersCorrectly() async {
        let mockService = MockNetworkService()
        let viewModel = ShowViewModel(networkService: mockService)

        mockService.mockData = [
            Show.mock(id: 1, name: "Breaking Bad"),
            Show.mock(id: 2, name: "Better Call Saul"),
            Show.mock(id: 3, name: "Stranger Things")
        ]
        
        await viewModel.fetchData(from: .shows)

        viewModel.filterShows(query: "breaking")

        XCTAssertEqual(viewModel.filteredShows.count, 1)
        XCTAssertEqual(viewModel.filteredShows.first?.name, "Breaking Bad")
    }

    func testFilterShows_WithEmptyQuery_ReturnsAll() async {
        let mockService = MockNetworkService()
        let viewModel = ShowViewModel(networkService: mockService)

        mockService.mockData = [
            Show.mock(id: 1, name: "Breaking Bad"),
            Show.mock(id: 2, name: "Better Call Saul"),
            Show.mock(id: 3, name: "Stranger Things")
        ]
        
        await viewModel.fetchData(from: .shows)

        viewModel.filterShows(query: "")
        XCTAssertEqual(viewModel.filteredShows.count, 3)
    }
}
