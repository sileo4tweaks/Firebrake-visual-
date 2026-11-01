//
//  InstalledView.swift
//  Firebreak
//

import SwiftUI

struct InstalledView: View {
    @EnvironmentObject var store: PackageStore

    var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                header
                if store.installed.isEmpty {
                    emptyState
                } else {
                    ForEach(store.installed) { tweak in
                        InstalledRow(tweak: tweak)
                    }
                }
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Installed")
                .font(.system(size: 34, weight: .heavy))
                .foregroundColor(Theme.gold)
            Text("\(store.installed.count) packages on this device")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.goldDim)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "arrow.down.app.fill")
                .font(.system(size: 56))
                .foregroundColor(Theme.gold.opacity(0.3))
            Text("No tweaks installed")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Theme.gold)
            Text("Browse the Featured tab to install your first package.")
                .font(.system(size: 13))
                .foregroundColor(Theme.goldDim)
                .multilineTextAlignment(.center)
        }
        .padding(40)
    }
}

struct InstalledRow: View {
    let tweak: Tweak
    @EnvironmentObject var store: PackageStore

    var body: some View {
        HStack(spacing: 16) {
            TweakIcon(kind: tweak.iconKind, size: 56)

            VStack(alignment: .leading, spacing: 3) {
                Text(tweak.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Theme.gold)
                Text(tweak.version)
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.gold.opacity(0.4))
            }

            Spacer()

            Button {
                store.uninstall(tweak)
            } label: {
                Text("Remove")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Theme.orange)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(
                        Capsule()
                            .fill(Theme.orange.opacity(0.15))
                            .overlay(Capsule().strokeBorder(Theme.orangeDim, lineWidth: 1))
                    )
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Theme.goldFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
