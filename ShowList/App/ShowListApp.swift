//
//  ShowListApp.swift
//  ShowList

import SwiftUI

@main
struct ShowListApp: App {
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = AppUIColor.background
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    var body: some Scene {
        WindowGroup {
            let service = NetworkService()
            let viewModel = ShowViewModel(networkService: service)
            ShowView(viewModel: viewModel)
        }
    }
}
