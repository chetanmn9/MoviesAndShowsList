//
//  HtmlToPlainText.swift
//  ShowList

import Foundation

extension String {
    public func htmlToPlainText() -> String {
        let data = Data(self.utf8)

        do {
            let attributed = try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            return attributed.string.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return self
        }
    }
}
