//
//  PackageStore.swift
//  Firebreak
//
//  In-memory store with seeded demo data matching the mockup.
//

import Foundation
import SwiftUI

@MainActor
final class PackageStore: ObservableObject {
    @Published var tweaks: [Tweak] = []
    @Published var repositories: [Repository] = []
    @Published var installed: [Tweak] = []
    @Published var featuredTweak: Tweak?

    init() {
        seed()
    }

    private func seed() {
        let featured = Tweak(
            name: "WalletBoost Pro",
            description: "Bank-grade tweaks for transactions, crypto tracking, and Apple Pay automation.",
            version: "v1.0.4",
            category: "FINANCIAL PACK",
            rating: 4.9,
            price: 9.99,
            iconKind: .wallet,
            repo: "firebreak.app"
        )
        featuredTweak = featured

        tweaks = [
            Tweak(
                name: "CryptoTracker X",
                description: "Real-time BTC / ETH / SOL widgets",
                version: "v2.4.1",
                category: "FINANCE",
                rating: 4.9,
                price: 4.99,
                iconKind: .crypto,
                repo: "firebreak.app"
            ),
            Tweak(
                name: "ApplePay Booster",
                description: "Bypass limits · Multi-currency",
                version: "v1.8.3",
                category: "WALLET",
                rating: 4.7,
                price: 6.99,
                iconKind: .applePay,
                repo: "firebreak.app"
            ),
            Tweak(
                name: "StockWidget Pro",
                description: "Live tickers on your Lock Screen",
                version: "v3.1.0",
                category: "WIDGETS",
                rating: 5.0,
                price: 2.99,
                iconKind: .stocks,
                repo: "chariz.com"
            ),
            Tweak(
                name: "StealthCard",
                description: "Virtual cards for every service",
                version: "v1.2.5",
                category: "PRIVACY",
                rating: 4.8,
                price: 12.99,
                iconKind: .stealth,
                repo: "firebreak.app"
            ),
            Tweak(
                name: "RespringKit",
                description: "One-tap respring · UICache · reload",
                version: "v0.9.7",
                category: "SYSTEM",
                rating: 4.6,
                price: 0,
                iconKind: .defaultGear,
                repo: "firebreak.app"
            ),
            Tweak(
                name: "TerminalUI",
                description: "Beautiful SSH client for root@iphone",
                version: "v2.0.1",
                category: "DEV",
                rating: 4.8,
                price: 3.49,
                iconKind: .terminal,
                repo: "packix.com"
            ),
        ]

        repositories = [
            Repository(
                url: URL(string: "https://repo.firebreak.app")!,
                name: "Firebreak Repo",
                suite: "Firebreak Team",
                packagesCount: 142,
                isPaid: true,
                pinned: true
            ),
            Repository(
                url: URL(string: "https://chariz.com")!,
                name: "Chariz",
                suite: "Chariz Inc.",
                packagesCount: 1284,
                isPaid: true,
                pinned: true
            ),
            Repository(
                url: URL(string: "https://repo.packix.com")!,
                name: "Packix",
                suite: "Packix Team",
                packagesCount: 932,
                isPaid: true,
                pinned: false
            ),
            Repository(
                url: URL(string: "https://apt.thebigboss.org")!,
                name: "BigBoss",
                suite: "BigBoss",
                packagesCount: 5210,
                isPaid: false,
                pinned: false
            ),
            Repository(
                url: URL(string: "https://apt.opsiottv.net")!,
                name: "iacks",
                suite: "iacks Team",
                packagesCount: 318,
                isPaid: true,
                pinned: false
            ),
        ]

        installed = Array(tweaks.prefix(2))
    }

    // MARK: - Actions
    func install(_ tweak: Tweak) {
        if !installed.contains(where: { $0.id == tweak.id }) {
            installed.append(tweak)
        }
    }

    func uninstall(_ tweak: Tweak) {
        installed.removeAll { $0.id == tweak.id }
    }

    func isInstalled(_ tweak: Tweak) -> Bool {
        installed.contains { $0.id == tweak.id }
    }
}
