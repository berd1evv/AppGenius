//
//  String+Extension.swift
//  AppGenius
//
//  Created by Eldiiar on 30/4/24.
//

import Foundation

extension String {
    func cleanedText() -> String {
        var cleanedText = self
        // Remove content inside parentheses including the parentheses themselves
        cleanedText = cleanedText.replacingOccurrences(of: "\\(.*?\\)", with: "", options: .regularExpression)
        // Remove square brackets and the content inside them
        cleanedText = cleanedText.replacingOccurrences(of: "[", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: "]", with: "")
        return cleanedText
    }
}
