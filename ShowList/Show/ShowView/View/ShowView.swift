//
//  ContentView.swift
//  ShowList


import SwiftUI

struct ShowView: View {
    @StateObject var viewModel: ShowViewModel
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Dark background

                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        showsListView
                            .onAppear {
                                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = AppUIColor.greyBackground
                                
                                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = AppUIColor.primaryText

                                let placeholderAttributes: [NSAttributedString.Key: Any] = [
                                    .foregroundColor: AppUIColor.greyBackground
                                ]
                                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
                                    .defaultTextAttributes = placeholderAttributes.merging(
                                        [.foregroundColor: UIColor.white],
                                        uniquingKeysWith: { $1 }
                                    )
                            }
                            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                            .onChange(of: searchText) {
                                viewModel.filterShows(query: searchText)
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("TV Shows")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            await viewModel.fetchData(from: .shows)
        }
    }

    private var showsListView: some View {
        List(viewModel.filteredShows, id: \.id) { show in
            NavigationLink(destination: ShowDetailView(show: show)) {
                ShowRowView(show: show)
            }
            .listRowBackground(Color.black)
        }
        .listStyle(.plain)
        .background(Color.black)
    }
}


#Preview("TV Shows") {
    let service = NetworkService()
    let viewModel = ShowViewModel(networkService: service)
    ShowView(viewModel: viewModel)
}

