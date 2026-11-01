//
//  RootTabView.swift
//  Firebreak
//

import SwiftUI

struct RootTabView: View {
    @State private var selectedTab: Tab = .featured

    enum Tab: Hashable {
        case featured, repos, search, installed, account
    }

    var body: some View {
        ZStack {
            // Backdrop
            Theme.emberBackdrop.ignoresSafeArea()

            VStack(spacing: 0) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                CustomTabBar(selected: $selectedTab)
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case .featured:
            FeaturedView()
        case .repos:
            ReposView()
        case .search:
            SearchView()
        case .installed:
            InstalledView()
        case .account:
            AccountView()
        }
    }
}

struct CustomTabBar: View {
    @Binding var selected: RootTabView.Tab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                tabItem(tab)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 28)
        .background(
            Rectangle()
                .fill(Theme.bgDeep.opacity(0.7))
                .background(.ultraThinMaterial)
                .overlay(
                    Rectangle()
                        .fill(Theme.gold.opacity(0.15))
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }

    private func tabItem(_ tab: RootTabView.Tab) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selected = tab
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: iconName(tab))
                    .font(.system(size: 22, weight: .medium))
                Text(title(tab))
                    .font(.system(size: 11, weight: .medium))
            }
            .foregroundColor(selected == tab ? Theme.gold : Theme.gold.opacity(0.4))
            .shadow(color: selected == tab ? Theme.gold.opacity(0.4) : .clear, radius: 4)
        }
    }

    private let tabs: [RootTabView.Tab] = [.featured, .repos, .search, .installed, .account]

    private func iconName(_ tab: RootTabView.Tab) -> String {
        switch tab {
        case .featured:  return "sparkles"
        case .repos:     return "shippingbox"
        case .search:    return "magnifyingglass"
        case .installed: return "arrow.down.app"
        case .account:   return "person.crop.circle"
        }
    }

    private func title(_ tab: RootTabView.Tab) -> String {
        switch tab {
        case .featured:  return "Featured"
        case .repos:     return "Repos"
        case .search:    return "Search"
        case .installed: return "Installed"
        case .account:   return "Account"
        }
    }
}
