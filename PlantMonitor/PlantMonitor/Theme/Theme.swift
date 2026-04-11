import SwiftUI

enum Theme {
    // ── Backgrounds ──
    static let background     = Color(hex: "#0a120d")
    static let cardBackground = Color.white.opacity(0.04)
    static let cardBorder     = Color.white.opacity(0.07)
    static let highlightCard  = Color(hex: "#4eca6e").opacity(0.10)
    static let highlightBorder = Color(hex: "#4eca6e").opacity(0.20)
    static let navBackground  = Color(hex: "#0a120d").opacity(0.92)

    // ── Greens ──
    static let accent         = Color(hex: "#4eca6e")   // bright green
    static let accentSoft     = Color(hex: "#7de89a")   // medium green text
    static let textPrimary    = Color(hex: "#e8f5e9")   // near-white green
    static let textSecondary  = Color(hex: "#c8e8cc")   // soft green
    static let textMuted      = Color(hex: "#a0d2aa").opacity(0.5)

    // ── Typography sizes ──
    static let heroSize: CGFloat    = 28
    static let valueSize: CGFloat   = 22
    static let labelSize: CGFloat   = 9
    static let subSize: CGFloat     = 10
    static let miniValueSize: CGFloat = 13
    static let miniLabelSize: CGFloat = 8

    // ── Corner radii ──
    static let cardRadius: CGFloat  = 16
    static let miniRadius: CGFloat  = 12
    static let chipRadius: CGFloat  = 20
    static let navRadius: CGFloat   = 0
}

// MARK: - Hex color init
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red:   Double(r) / 255,
                  green: Double(g) / 255,
                  blue:  Double(b) / 255,
                  opacity: Double(a) / 255)
    }
}
