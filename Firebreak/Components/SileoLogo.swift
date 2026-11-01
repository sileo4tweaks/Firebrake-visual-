//
//  SileoLogo.swift
//  Firebreak
//
//  Renders the Sileo-style droplet logo using SwiftUI primitives.
//

import SwiftUI

struct SileoLogo: View {
    var size: CGFloat = 56

    var body: some View {
        ZStack {
            // Outer rounded square with gold-orange gradient
            RoundedRectangle(cornerRadius: size * 0.275, style: .continuous)
                .fill(Theme.goldOrange)
                .frame(width: size, height: size)
                .shadow(color: Theme.gold.opacity(0.5), radius: size * 0.2)

            // Inner glass border
            RoundedRectangle(cornerRadius: size * 0.225, style: .continuous)
                .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                .frame(width: size * 0.9, height: size * 0.9)

            // Droplet
            DropletShape()
                .fill(Color.white.opacity(0.95))
                .frame(width: size * 0.34, height: size * 0.44)
                .offset(y: size * 0.02)

            // Droplet highlight
            DropletShape()
                .fill(Theme.gold.opacity(0.7))
                .frame(width: size * 0.08, height: size * 0.12)
                .offset(x: -size * 0.06, y: size * 0.06)

            // Top sheen
            Ellipse()
                .fill(Color.white.opacity(0.4))
                .frame(width: size * 0.4, height: size * 0.06)
                .offset(y: -size * 0.2)
        }
        .frame(width: size, height: size)
    }
}

struct DropletShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let cx = rect.midX
        // Top point of the droplet
        path.move(to: CGPoint(x: cx, y: rect.minY))
        // Right curve down to bottom
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY + h * 0.15),
            control: CGPoint(x: cx + w * 0.5, y: rect.minY + h * 0.35)
        )
        // Bottom right curve to bottom center
        path.addQuadCurve(
            to: CGPoint(x: cx, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.maxY - h * 0.05)
        )
        // Bottom left curve to left middle
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY + h * 0.15),
            control: CGPoint(x: rect.minX, y: rect.maxY - h * 0.05)
        )
        // Left curve back to top
        path.addQuadCurve(
            to: CGPoint(x: cx, y: rect.minY),
            control: CGPoint(x: cx - w * 0.5, y: rect.minY + h * 0.35)
        )
        path.closeSubpath()
        return path
    }
}

#Preview {
    ZStack {
        Color.black
        SileoLogo(size: 96)
    }
}
