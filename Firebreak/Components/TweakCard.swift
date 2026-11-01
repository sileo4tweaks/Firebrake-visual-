//
//  TweakCard.swift
//  Firebreak
//

import SwiftUI

struct TweakCard: View {
    let tweak: Tweak
    @EnvironmentObject var store: PackageStore

    var body: some View {
        HStack(spacing: 16) {
            TweakIcon(kind: tweak.iconKind, size: 64)

            VStack(alignment: .leading, spacing: 3) {
                Text(tweak.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Theme.gold)
                    .lineLimit(1)

                Text(tweak.description)
                    .font(.system(size: 13))
                    .foregroundColor(Theme.goldDim)
                    .lineLimit(1)

                HStack(spacing: 8) {
                    Text(tweak.version)
                    Text("·").foregroundColor(Theme.gold.opacity(0.3))
                    Text(tweak.category)
                    Text("·").foregroundColor(Theme.gold.opacity(0.3))
                    Text(tweak.ratingString)
                }
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.gold.opacity(0.4))
            }

            Spacer(minLength: 0)

            Text(tweak.priceString)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Theme.gold)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Theme.capsuleFill)
                        .overlay(
                            Capsule().strokeBorder(Theme.gold.opacity(0.3), lineWidth: 1)
                        )
                )
                .shadow(color: Theme.gold.opacity(0.15), radius: 4)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Theme.goldFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
