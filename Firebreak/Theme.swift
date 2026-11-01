//
//  Theme.swift
//  Firebreak
//
//  Fire-gold Liquid Glass design tokens.
//

import SwiftUI

enum Theme {
    // MARK: - Colors
    static let bgDeep       = Color(hex: 0x0A0506)
    static let bgSurface    = Color(hex: 0x0C0608)
    static let bgElevated   = Color(hex: 0x120606)

    static let gold         = Color(hex: 0xFFD700)
    static let goldDim      = Color(hex: 0xFFD700).opacity(0.5)
    static let goldFaint    = Color(hex: 0xFFD700).opacity(0.08)
    static let orange       = Color(hex: 0xFF6B00)
    static let orangeDim    = Color(hex: 0xFF6B00).opacity(0.4)
    static let ember        = Color(hex: 0xFFA500)

    // MARK: - Gradients
    static let goldOrange = LinearGradient(
        colors: [gold, orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let goldOrangeVertical = LinearGradient(
        colors: [gold, orange],
        startPoint: .top,
        endPoint: .bottom
    )

    static let goldGlow = RadialGradient(
        colors: [gold.opacity(0.3), .clear],
        center: .center,
        startRadius: 0,
        endRadius: 200
    )

    static let emberBackdrop = LinearGradient(
        stops: [
            .init(color: Color(hex: 0x0a0608), location: 0),
            .init(color: Color(hex: 0x0c0a05), location: 0.4),
            .init(color: Color(hex: 0x150905), location: 0.7),
            .init(color: Color(hex: 0x1a0a02), location: 1),
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Capsule styles
    static let capsuleFill = LinearGradient(
        colors: [Color(hex: 0xFFD700).opacity(0.2), Color(hex: 0xFF6B00).opacity(0.2)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        self = Color(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}

// MARK: - View Modifiers

struct LiquidGlassBackground: ViewModifier {
    var cornerRadius: CGFloat = 24
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Theme.goldFaint)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(Theme.gold.opacity(0.15), lineWidth: 1)
                    )
                    .shadow(color: Theme.gold.opacity(0.05), radius: 8, y: 4)
            )
    }
}

extension View {
    func liquidGlass(cornerRadius: CGFloat = 24, padding: CGFloat = 16) -> some View {
        modifier(LiquidGlassBackground(cornerRadius: cornerRadius, padding: padding))
    }
}
