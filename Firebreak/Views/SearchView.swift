//
//  SearchView.swift
//  Firebreak
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var store: PackageStore
    @State private var query: String = ""

    private var results: [Tweak] {
        guard !query.isEmpty else { return store.tweaks }
        return store.tweaks.filter {
            $0.name.localizedCaseInsensitiveContains(query)
                || $0.description.localizedCaseInsensitiveContains(query)
                || $0.category.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            searchBar
            if query.isEmpty {
                suggestionsView
            } else {
                resultList
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 16)
    }

    private var searchBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Theme.gold.opacity(0.7))
            TextField("", text: $query, prompt:
                Text("Search tweaks, repos, themes...")
                    .foregroundColor(Theme.gold.opacity(0.4))
            )
            .font(.system(size: 16))
            .foregroundColor(Theme.gold)
            if !query.isEmpty {
                Button {
                    query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Theme.gold.opacity(0.4))
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 56)
        .background(
            Capsule()
                .fill(Theme.goldFaint)
                .overlay(Capsule().strokeBorder(Theme.gold.opacity(0.15), lineWidth: 1))
        )
    }

    private var suggestionsView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("SUGGESTED")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.gold.opacity(0.5))
                    .tracking(1.5)

                ForEach(["Wallet", "Crypto", "Apple Pay", "Respring", "Terminal", "Theme"], id: \.self) { term in
                    Button {
                        query = term
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Theme.gold.opacity(0.4))
                            Text(term)
                                .foregroundColor(Theme.gold)
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                                .foregroundColor(Theme.gold.opacity(0.3))
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Theme.goldFaint)
                        )
                    }
                }
            }
        }
    }

    private var resultList: some View {
        ScrollView {
            VStack(spacing: 14) {
                Text("\(results.count) result\(results.count == 1 ? "" : "s")")
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.gold.opacity(0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(results) { tweak in
                    TweakCard(tweak: tweak)
                }
            }
        }
    }
}
