//
//  ShowDetailsView.swift
//  ShowList


import SwiftUI

struct ShowDetailView: View {
    let show: Show

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                Divider()
                    .background(AppColor.secondaryText)
                summarySection
                    .padding(.top, 18)
                    .padding(.bottom, 18)
                Divider()
                    .background(AppColor.secondaryText)
                ratingSection
                    .padding(.top, 12)
            }
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .padding(.top, 12)
        }
        .background(AppColor.background.ignoresSafeArea())
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Header Section

    private var headerSection: some View {
        HStack(alignment: .top, spacing: 12) {
            showImage
            VStack(alignment: .leading, spacing: 3) {
                showName
                year
                timeSlot
                genre
            }
            .padding(.top, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 12)
    }

    // MARK: - Subviews
    
    var showImage: some View {
        Group {
            if let url = URL(string: show.image.original) {
                let viewModel = ShowImageViewModel(url: url)
                ShowImageView(viewModel: viewModel)
            }
        }
    }

    private var showName: some View {
        Text(show.name)
            .font(.title3)
            .foregroundColor(AppColor.primaryText)
            .accessibilityLabel("Show title: \(show.name)")
    }

    private var year: some View {
        Text(show.year)
            .font(.headline)
            .foregroundColor(AppColor.secondaryText)
    }

    private var timeSlot: some View {
        Text(show.timeSlot)
            .font(.headline)
            .foregroundColor(AppColor.secondaryText)
    }

    private var genre: some View {
        Text(show.genreDisplay)
            .font(.footnote)
            .foregroundColor(AppColor.primaryText)
    }

    private var summarySection: some View {
        Text(show.summaryInString)
            .font(.body)
            .foregroundColor(AppColor.primaryText)
            .accessibilityLabel("Summary: \(show.summaryInString)")
    }

    private var ratingSection: some View {
        HStack {
            Text("Average Rating: \(String(format: "%.1f", show.rating.average ?? 0.0))")
                .font(.footnote)
                .foregroundColor(AppColor.primaryText)
            Spacer()
        }
    }
}


#Preview("TV Shows") {
    ShowDetailView(show: .mock)
}

