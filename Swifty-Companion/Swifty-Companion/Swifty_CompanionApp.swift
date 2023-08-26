//
//  Swifty_CompanionApp.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 19.8.2023.
//

import SwiftUI
import OAuthSwift

@main
struct Swifty_CompanionApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .onOpenURL(perform: { url in
                    OAuthSwift.handle(url: url)
                })
        }
    }
}

