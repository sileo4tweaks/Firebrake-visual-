//
//  Repository.swift
//  Firebreak
//

import Foundation

struct Repository: Identifiable, Hashable {
    let id: UUID
    var url: URL
    var name: String
    var suite: String
    var packagesCount: Int
    var isPaid: Bool
    var pinned: Bool

    init(
        id: UUID = UUID(),
        url: URL,
        name: String,
        suite: String,
        packagesCount: Int,
        isPaid: Bool = false,
        pinned: Bool = false
    ) {
        self.id = id
        self.url = url
        self.name = name
        self.suite = suite
        self.packagesCount = packagesCount
        self.isPaid = isPaid
        self.pinned = pinned
    }
}
