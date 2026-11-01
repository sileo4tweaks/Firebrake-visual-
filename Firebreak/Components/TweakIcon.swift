//
//  TweakIcon.swift
//  Firebreak
//
//  Renders per-category icons used in tweak cards.
//

import SwiftUI

struct TweakIcon: View {
    let kind: IconKind
    var size: CGFloat = 64

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Theme.orange.opacity(0.3), Theme.gold.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                        .strokeBorder(Theme.gold.opacity(0.2), lineWidth: 1)
                )
                .frame(width: size, height: size)

            iconContent
                .frame(width: size * 0.56, height: size * 0.56)
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder
    private var iconContent: some View {
        switch kind {
        case .wallet:
            walletIcon
        case .crypto:
            cryptoIcon
        case .applePay:
            applePayIcon
        case .stocks:
            stocksIcon
        case .stealth:
            stealthIcon
        case .chip:
            chipIcon
        case .terminal:
            terminalIcon
        case .defaultGear:
            gearIcon
        }
    }

    private var walletIcon: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Theme.gold.opacity(0.9))
                Rectangle()
                    .fill(Color.black.opacity(0.8))
                    .frame(height: size * 0.12)
                    .frame(maxWidth: .infinity, alignment: .top)
            }
            Rectangle()
                .fill(Theme.orange)
                .frame(height: size * 0.06)
            HStack {
                Rectangle()
                    .fill(Theme.orange)
                    .frame(width: size * 0.1, height: size * 0.1)
                Spacer()
                Circle()
                    .fill(Theme.orange)
                    .frame(width: size * 0.08)
            }
            .padding(.horizontal, size * 0.06)
            .padding(.top, size * 0.04)
            Spacer()
        }
    }

    private var cryptoIcon: some View {
        ZStack {
            Circle()
                .fill(Theme.orange.opacity(0.85))
            Text("$")
                .font(.system(size: size * 0.32, weight: .black, design: .default))
                .foregroundColor(.white)
        }
    }

    private var applePayIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.1)
                .fill(Theme.gold.opacity(0.9))
            Text("")
                .font(.system(size: size * 0.2, weight: .black))
                .foregroundColor(.black)
        }
    }

    private var stocksIcon: some View {
        VStack(spacing: 0) {
            PolylineShape(points: [
                CGPoint(x: 0, y: 1.0),
                CGPoint(x: 0.3, y: 0.55),
                CGPoint(x: 0.5, y: 0.7),
                CGPoint(x: 0.75, y: 0.2),
                CGPoint(x: 1.0, y: 0.35),
            ])
            .stroke(Theme.gold, style: StrokeStyle(lineWidth: size * 0.05, lineCap: .round, lineJoin: .round))
            Circle()
                .fill(Theme.orange)
                .frame(width: size * 0.1)
                .offset(x: size * 0.2, y: -size * 0.18)
        }
    }

    private var stealthIcon: some View {
        VStack(spacing: size * 0.04) {
            Rectangle()
                .fill(Theme.gold.opacity(0.9))
                .frame(height: size * 0.1)
            Rectangle()
                .fill(Color.black.opacity(0.6))
                .frame(height: size * 0.06)
            HStack(spacing: size * 0.04) {
                Rectangle().fill(Theme.orange).frame(height: size * 0.04)
                Rectangle().fill(Theme.orange).frame(width: size * 0.3, height: size * 0.04)
            }
            HStack(spacing: size * 0.04) {
                Rectangle().fill(Theme.orange).frame(height: size * 0.04)
                Rectangle().fill(Theme.orange.opacity(0.6)).frame(width: size * 0.18, height: size * 0.04)
            }
        }
    }

    private var chipIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.1)
                .stroke(Theme.gold, lineWidth: 1.5)
            RoundedRectangle(cornerRadius: size * 0.05)
                .stroke(Theme.orange.opacity(0.7), lineWidth: 1)
                .padding(size * 0.08)
            Circle()
                .fill(Theme.gold)
                .frame(width: size * 0.1)
        }
    }

    private var terminalIcon: some View {
        VStack(alignment: .leading, spacing: size * 0.03) {
            HStack(spacing: size * 0.03) {
                Text("$")
                    .font(.system(size: size * 0.16, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.gold)
                Rectangle()
                    .fill(Theme.gold)
                    .frame(width: size * 0.2, height: size * 0.04)
            }
            Rectangle()
                .fill(Theme.orange)
                .frame(width: size * 0.4, height: size * 0.03)
            Rectangle()
                .fill(Theme.orange.opacity(0.5))
                .frame(width: size * 0.3, height: size * 0.03)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(size * 0.06)
    }

    private var gearIcon: some View {
        Image(systemName: "gearshape.fill")
            .font(.system(size: size * 0.3, weight: .semibold))
            .foregroundColor(Theme.gold)
    }
}

private struct PolylineShape: Shape {
    let points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let first = points.first else { return path }
        path.move(to: CGPoint(x: first.x * rect.width, y: first.y * rect.height))
        for p in points.dropFirst() {
            path.addLine(to: CGPoint(x: p.x * rect.width, y: p.y * rect.height))
        }
        return path
    }
}
