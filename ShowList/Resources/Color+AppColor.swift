//
//  Color+AppColor.swift
//  ShowList

import SwiftUI

// MARK: - App Colour Palette
struct AppColor {
    static let background = Color(hex: "#000000")
    static let primaryText = Color(hex: "#FFFFFF")
    static let secondaryText = Color(hex: "#808080")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

