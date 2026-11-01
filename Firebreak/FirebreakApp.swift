//
//  FirebreakApp.swift
//  Firebreak
//
//  Concept iOS app that mimics a Sileo-style package manager UI
//  for jailbroken devices. Pure SwiftUI, no private APIs.
//

import SwiftUI

@main
struct FirebreakApp: App {
    @StateObject private var store = PackageStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }
}
