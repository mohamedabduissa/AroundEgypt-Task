//
//  FontLoader.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

import Foundation
import CoreText

public class FontLoader {

    public static func registerFonts(from folder: String? = nil) {
        guard let fontURLs = Bundle.main.urls(forResourcesWithExtension: nil, subdirectory: folder) else {
            return
        }

        for url in fontURLs where url.pathExtension == "ttf" || url.pathExtension == "otf" {
            registerFont(at: url)
        }
    }

    private static func registerFont(at url: URL) {
        if #available(iOS 18.0, *) {
            let _ = CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        } else {
            do {
                let fontData = try Data(contentsOf: url) as CFData
                guard let provider = CGDataProvider(data: fontData),
                      let font = CGFont(provider) else {
                    return
                }

                var error: Unmanaged<CFError>?
                if CTFontManagerRegisterGraphicsFont(font, &error) {
                } else {
                    let _ = error?.takeUnretainedValue().localizedDescription ?? "Unknown"
                }
            } catch {

            }
        }
    }
}
