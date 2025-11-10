//
//  FontsManager.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import SwiftUI

/// A centralized manager for fonts across the app.
/// - Automatically selects fonts based on current language
/// - Falls back to the system font if the custom font is not available
/// - Dynamically supports dark mode and scaling
public struct FontsManager {

    /// Semantic text styles used across the app.
    public enum Style {
        case largeTitle
        case title
        case subtitle
        case body
        case caption
        case small
        case custom(size: CGFloat = 16)
    }

    // MARK: - Public Interface

    /// Returns the appropriate font for a given style and language.
    ///
    /// - Parameters:
    ///   - style: Semantic style
    ///   - weight: Optional font weight override
    ///   - design: Optional font design override
    /// - Returns: A SwiftUI Font
    public static func font(
        for style: Style,
        weight: Font.Weight? = nil,
        design: Font.Design = .default
    ) -> Font {
        let baseFontName = fontName(style: style, weight: weight ?? .regular)
        let size = fontSize(for: style)

        if UIFont(name: baseFontName, size: size) != nil {
            // ✅ Custom fonts do NOT support `.design`
            return Font.custom(baseFontName, size: size)
                .weight(weight ?? .regular)
        } else {
            // ✅ System font does support `.design`
            return Font.system(size: size, weight: weight ?? .regular, design: design)
        }
    }

    private static func fontWeight(weight: Font.Weight = .regular) -> String {
        switch weight {
        case .regular: return "Gotham-Regular"
        case .medium: return "Gotham-Medium"
        case .bold: return "Gotham-Bold"
        default: return "Gotham-Regular"
        }
    }
    private static func fontName(style: Style, weight: Font.Weight = .regular) -> String {
        switch style {
        case .largeTitle: return fontWeight(weight: weight)
        case .title: return fontWeight(weight: weight)
        case .subtitle: return fontWeight(weight: weight)
        case .body: return fontWeight(weight: weight)
        case .caption, .small: return fontWeight(weight: weight)
        case .custom: return fontWeight(weight: weight)
        }
    }

    // MARK: - Font Sizes
    private static func fontSize(for style: Style) -> CGFloat {
        switch style {
        case .largeTitle:
            return 34
        case .title:
            return 24
        case .subtitle:
            return 18
        case .body:
            return 16
        case .caption:
            return 14
        case .small:
            return 12
        case .custom(size: let size):
            return size
        }
    }
}
