//
//  FeaturedBanner.swift
//  Firebreak
//

import SwiftUI

struct FeaturedBanner: View {
    let tweak: Tweak

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background: clipped to rounded rect, no .fill(ZStack)
            ZStack {
                LinearGradient(
                    colors: [
                        Theme.orange.opacity(0.3),
                        Theme.gold.opacity(0.15),
                        Color.black.opacity(0.4),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                RadialGradient(
                    colors: [Theme.gold.opacity(0.3), .clear],
                    center: UnitPoint(x: 0.8, y: 0.2),
                    startRadius: 0,
                    endRadius: 200
                )
            }
            .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 32, style: .continuous)
                    .strokeBorder(Theme.gold.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.4), radius: 10, y: 6)

            VStack(alignment: .leading, spacing: 14) {
                Text("★ \(tweak.category)")
                    .font(.system(size: 11, weight: .bold))
                    .foregroundColor(Theme.gold)
                    .textCase(.uppercase)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(
                        Capsule().fill(Theme.orange.opacity(0.3))
                    )

                Text(tweak.name)
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(Theme.gold)
                    .lineLimit(2)

                Text(tweak.description)
                    .font(.system(size: 14))
                    .foregroundColor(Theme.gold.opacity(0.65))
                    .lineLimit(2)

                HStack(spacing: 8) {
                    Text(tweak.priceString)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Text("·").foregroundColor(.black.opacity(0.6))
                    Text("BUY NOW")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Theme.goldOrange)
                        .shadow(color: Theme.orange.opacity(0.5), radius: 6, y: 4)
                )
            }
            .padding(28)
        }
        .frame(height: 220)
    }
}
