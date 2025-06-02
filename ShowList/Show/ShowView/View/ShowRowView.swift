//
//  ShowRowView.swift
//  ShowList

import SwiftUI

struct ShowRowView: View {
    let show: Show

    var body: some View {
        HStack {
//            AsyncImage(url: URL(string: show.image.original)) { image in
//                image
//                    .resizable()
//            } placeholder: {
//                ProgressView()
//            }
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 128)
            
            Group {
                if let url = URL(string: show.image.original) {
                    let viewModel = ShowImageViewModel(url: url)
                    ShowImageView(viewModel: viewModel)
                }
            }

            VStack(alignment: .leading) {
                Text(show.name)
                    .font(.title3)
                    .foregroundColor(AppColor.primaryText)
                    .foregroundStyle(.primary)
                Text(show.timeSlot)
                    .font(.body)
                    .foregroundColor(AppColor.secondaryText)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    List {
        ShowRowView(show: .mock)
    }
}
