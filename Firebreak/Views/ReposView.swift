//
//  ReposView.swift
//  Firebreak
//

import SwiftUI

struct ReposView: View {
    @EnvironmentObject var store: PackageStore

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                header
                ForEach(store.repositories) { repo in
                    RepoRow(repo: repo)
                }
                Spacer(minLength: 24)
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Repositories")
                .font(.system(size: 34, weight: .heavy))
                .foregroundColor(Theme.gold)
            Text("\(store.repositories.count) sources · synced just now")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.goldDim)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 8)
    }
}

struct RepoRow: View {
    let repo: Repository

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(Theme.goldOrange.opacity(repo.isPaid ? 0.25 : 0.1))
                    .frame(width: 56, height: 56)
                Image(systemName: repo.isPaid ? "dollarsign.circle.fill" : "shippingbox.fill")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(Theme.gold)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(repo.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Theme.gold)
                    if repo.pinned {
                        Image(systemName: "pin.fill")
                            .font(.system(size: 10))
                            .foregroundColor(Theme.orange)
                    }
                }
                Text(repo.url.absoluteString)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.goldDim)
                HStack(spacing: 8) {
                    Text("\(repo.packagesCount) packages")
                    Text("·").foregroundColor(Theme.gold.opacity(0.3))
                    Text(repo.suite)
                }
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.gold.opacity(0.4))
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Theme.goldFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
