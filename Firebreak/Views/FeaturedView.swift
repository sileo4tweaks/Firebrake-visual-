//
//  FeaturedView.swift
//  Firebreak
//

import SwiftUI

struct FeaturedView: View {
    @EnvironmentObject var store: PackageStore

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                header
                searchBar
                if let featured = store.featuredTweak {
                    FeaturedBanner(tweak: featured)
                }
                sectionHeader
                tweaksList
            }
            .padding(.horizontal, 36)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .background(Color.clear)
    }

    private var header: some View {
        HStack {
            HStack(spacing: 14) {
                SileoLogo(size: 56)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sileo")
                        .font(.system(size: 38, weight: .heavy))
                        .foregroundStyle(Theme.goldOrange)
                    Text("Firebreak Repo")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Theme.goldDim)
                        .textCase(.uppercase)
                        .tracking(1)
                }
            }
            Spacer()
            Text("JB ACTIVE")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Theme.orange)
                .textCase(.uppercase)
                .tracking(1)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(
                    Capsule()
                        .fill(Theme.orange.opacity(0.15))
                        .overlay(Capsule().strokeBorder(Theme.orangeDim, lineWidth: 1))
                )
                .shadow(color: Theme.orange.opacity(0.2), radius: 8)
        }
    }

    private var searchBar: some View {
        HStack(spacing: 14) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Theme.gold.opacity(0.7))
                .font(.system(size: 18, weight: .medium))
            Text("Search tweaks, repos, themes...")
                .font(.system(size: 18))
                .foregroundColor(Theme.gold.opacity(0.4))
            Spacer()
            Text("⌘K")
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(Theme.gold.opacity(0.6))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Theme.gold.opacity(0.1))
                )
        }
        .padding(.horizontal, 24)
        .frame(height: 60)
        .background(
            Capsule()
                .fill(Theme.goldFaint)
                .overlay(Capsule().strokeBorder(Theme.gold.opacity(0.15), lineWidth: 1))
        )
    }

    private var sectionHeader: some View {
        HStack {
            Text("Paid Tweaks")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Theme.gold)
            Spacer()
            Text("See all →")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Theme.orange)
        }
    }

    private var tweaksList: some View {
        VStack(spacing: 14) {
            ForEach(store.tweaks) { tweak in
                TweakCard(tweak: tweak)
            }
        }
    }
}
