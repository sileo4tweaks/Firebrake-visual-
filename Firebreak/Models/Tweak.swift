//
//  Tweak.swift
//  Firebreak
//
//  Data model for a Sileo package / tweak.
//

import SwiftUI

struct Tweak: Identifiable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var version: String
    var category: String
    var rating: Double
    var price: Double          // 0 = free
    var iconKind: IconKind
    var repo: String

    var priceString: String {
        price == 0 ? "FREE" : String(format: "$%.2f", price)
    }

    var ratingString: String {
        String(format: "★ %.1f", rating)
    }

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        version: String,
        category: String,
        rating: Double,
        price: Double,
        iconKind: IconKind,
        repo: String
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.version = version
        self.category = category
        self.rating = rating
        self.price = price
        self.iconKind = iconKind
        self.repo = repo
    }
}

enum IconKind: String, Hashable {
    case wallet
    case crypto
    case applePay
    case stocks
    case stealth
    case chip
    case terminal
    case defaultGear
}
