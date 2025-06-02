//
//  ImageView.swift
//  ShowList


import SwiftUI

struct ShowImageView: View {
    
    @StateObject var viewModel: ShowImageViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                SwiftUI.Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 180)
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            }
            else {
                ProgressView()
                    .tint(.white)
                    .frame(width: 120, height: 180)
            }
        }
        .onAppear {
            viewModel.downloadImage()
        }
    }
}
