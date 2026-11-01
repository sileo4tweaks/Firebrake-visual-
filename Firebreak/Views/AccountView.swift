//
//  AccountView.swift
//  Firebreak
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var store: PackageStore

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                profileHeader
                statsRow
                actionsList
                Spacer(minLength: 20)
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
        }
    }

    private var profileHeader: some View {
        HStack(spacing: 18) {
            ZStack {
                Circle()
                    .fill(Theme.goldOrange)
                    .frame(width: 80, height: 80)
                    .shadow(color: Theme.gold.opacity(0.4), radius: 12)
                Text("F")
                    .font(.system(size: 36, weight: .black))
                    .foregroundColor(.black)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Firebreak User")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Theme.gold)
                Text("firebreak@user.id")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.goldDim)
                Text("PRO MEMBER")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Capsule().fill(Theme.goldOrange))
                    .padding(.top, 4)
            }
            Spacer()
        }
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCard(title: "Installed", value: "\(store.installed.count)")
            statCard(title: "Repos", value: "\(store.repositories.count)")
            statCard(title: "Paid", value: "\(store.tweaks.filter { $0.price > 0 }.count)")
        }
    }

    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundColor(Theme.gold)
            Text(title)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .foregroundColor(Theme.gold.opacity(0.5))
                .tracking(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Theme.goldFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.1), lineWidth: 1)
                )
        )
    }

    private var actionsList: some View {
        VStack(spacing: 12) {
            actionRow(icon: "arrow.triangle.2.circlepath", title: "Respring Now", subtitle: "Reload SpringBoard · UICache")
            actionRow(icon: "creditcard.fill", title: "Payment Methods", subtitle: "Visa •••• 1337 · Apple Pay")
            actionRow(icon: "doc.text.fill", title: "Purchase History", subtitle: "12 packages purchased")
            actionRow(icon: "gearshape.fill", title: "Settings", subtitle: "Bootstrap, themes, signatures")
            actionRow(icon: "info.circle.fill", title: "About Firebreak", subtitle: "v3.0.1 · Dopamine fork")
        }
    }

    private func actionRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Theme.goldFaint)
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(Theme.gold)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Theme.gold)
                Text(subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(Theme.goldDim)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Theme.gold.opacity(0.3))
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Theme.goldFaint)
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
