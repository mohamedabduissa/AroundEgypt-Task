//
//  AroundEgyptApp.swift
//  AroundEgyptApp
//
//  Created by MacbookPro on 09/11/2025.
//

import SwiftUI

@main
struct AroundEgyptApp: App {
    
    init() {
        FontLoader.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

