//
//  ShowDetailViewModel.swift
//  ShowList

import Foundation
import UIKit

class ShowImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func downloadImage() {
        Task {
            if image == nil {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let image = UIImage(data: data)
                    await MainActor.run {
                        self.image = image ?? UIImage(systemName: "photo")
                    }
                } catch {
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
