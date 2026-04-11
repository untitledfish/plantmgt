import SwiftUI

// ─────────────────────────────────────────────
// MARK: - Primary Stat Card (2-col grid)
// ─────────────────────────────────────────────
struct StatCard: View {
    let icon: String
    let label: String
    let value: String
    let unit: String
    var subtext: String? = nil
    var isHighlighted: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(icon)
                .font(.system(size: 18))

            Text(label)
                .font(.system(size: Theme.labelSize, design: .monospaced))
                .foregroundColor(Theme.textMuted)
                .textCase(.uppercase)
                .tracking(1.2)

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: Theme.valueSize, weight: .medium, design: .monospaced))
                    .foregroundColor(Theme.textPrimary)
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.4), value: value)
                Text(unit)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(Theme.textMuted)
            }

            if let sub = subtext {
                Text(sub)
                    .font(.system(size: Theme.subSize, design: .monospaced))
                    .foregroundColor(Theme.textMuted)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: Theme.cardRadius)
                .fill(isHighlighted ? Theme.highlightCard : Theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cardRadius)
                        .stroke(isHighlighted ? Theme.highlightBorder : Theme.cardBorder, lineWidth: 1)
                )
        )
        .overlay(alignment: .top) {
            // Top shimmer line
            LinearGradient(
                colors: [.clear, Theme.accent.opacity(0.3), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - pH Wide Card
// ─────────────────────────────────────────────
struct PHCard: View {
    let current: Double
    let low: Double
    let high: Double

    private var isInRange: Bool { current >= low && current <= high }

    // Fill ratio: map current pH across [low-1 ... high+1]
    private var fillRatio: Double {
        let min = low - 1.0
        let max = high + 1.0
        return ((current - min) / (max - min)).clamped(to: 0...1)
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("⚗️")
                        .font(.system(size: 18))
                    Text("pH Level")
                        .font(.system(size: Theme.labelSize, design: .monospaced))
                        .foregroundColor(Theme.textMuted)
                        .textCase(.uppercase)
                        .tracking(1.2)

                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text(String(format: "%.1f", current))
                            .font(.system(size: Theme.valueSize, weight: .medium, design: .monospaced))
                            .foregroundColor(Theme.textPrimary)
                            .contentTransition(.numericText())
                            .animation(.easeInOut(duration: 0.4), value: current)
                        Text("pH")
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(Theme.textMuted)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text("Target")
                        .font(.system(size: Theme.labelSize, design: .monospaced))
                        .foregroundColor(Theme.textMuted)
                        .textCase(.uppercase)
                        .tracking(1.2)
                    Text(String(format: "%.1f – %.1f", low, high))
                        .font(.system(size: 16, weight: .medium, design: .monospaced))
                        .foregroundColor(Theme.accentSoft)

                    HStack(spacing: 4) {
                        Circle()
                            .fill(isInRange ? Theme.accent : Color.orange)
                            .frame(width: 6, height: 6)
                            .shadow(color: isInRange ? Theme.accent : .orange, radius: 3)
                        Text(isInRange ? "IN RANGE" : "OUT OF RANGE")
                            .font(.system(size: 9, weight: .medium, design: .monospaced))
                            .foregroundColor(isInRange ? Theme.accent : .orange)
                            .tracking(0.8)
                    }
                }
            }

            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.08))
                        .frame(height: 4)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(
                            LinearGradient(
                                colors: [Theme.accent, Color(hex: "#a8e063")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * fillRatio, height: 4)
                        .animation(.easeInOut(duration: 0.6), value: fillRatio)
                }
            }
            .frame(height: 4)
            .padding(.top, 10)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: Theme.cardRadius)
                .fill(Theme.highlightCard)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.cardRadius)
                        .stroke(Theme.highlightBorder, lineWidth: 1)
                )
        )
        .overlay(alignment: .top) {
            LinearGradient(
                colors: [.clear, Theme.accent.opacity(0.3), .clear],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(height: 1)
            .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Mini Stat Card (3-col grid)
// ─────────────────────────────────────────────
struct MiniStatCard: View {
    let icon: String
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(icon)
                .font(.system(size: 16))
            Text(value)
                .font(.system(size: Theme.miniValueSize, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.textSecondary)
                .contentTransition(.numericText())
                .animation(.easeInOut(duration: 0.4), value: value)
            Text(label)
                .font(.system(size: Theme.miniLabelSize, design: .monospaced))
                .foregroundColor(Theme.textMuted)
                .multilineTextAlignment(.center)
                .tracking(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: Theme.miniRadius)
                .fill(Theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.miniRadius)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
        )
    }
}

// ─────────────────────────────────────────────
// MARK: - Last Watered Row
// ─────────────────────────────────────────────
struct LastWateredRow: View {
    let formatted: String
    let relative: String

    var body: some View {
        HStack {
            HStack(spacing: 10) {
                Text("🚿")
                    .font(.system(size: 18))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Last Watered")
                        .font(.system(size: Theme.labelSize, design: .monospaced))
                        .foregroundColor(Theme.textMuted)
                        .textCase(.uppercase)
                        .tracking(1.0)
                    Text(formatted)
                        .font(.system(size: 15))
                        .foregroundColor(Theme.textSecondary)
                }
            }
            Spacer()
            Text(relative)
                .font(.system(size: Theme.subSize, weight: .medium, design: .monospaced))
                .foregroundColor(Theme.accent)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Theme.cardBorder, lineWidth: 1)
                )
        )
    }
}

// ─────────────────────────────────────────────
// MARK: - Live Pulse Badge
// ─────────────────────────────────────────────
struct LiveBadge: View {
    let potID: String
    @State private var pulsing = false

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(Theme.accent)
                .frame(width: 6, height: 6)
                .shadow(color: Theme.accent, radius: pulsing ? 4 : 1)
                .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulsing)
                .onAppear { pulsing = true }

            Text("LIVE · \(potID)")
                .font(.system(size: 10, design: .monospaced))
                .foregroundColor(Theme.accentSoft)
                .tracking(1.0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Theme.accent.opacity(0.12))
                .overlay(Capsule().stroke(Theme.accent.opacity(0.25), lineWidth: 1))
        )
    }
}

// ─────────────────────────────────────────────
// MARK: - Section Label
// ─────────────────────────────────────────────
struct SectionLabel: View {
    let text: String
    var body: some View {
        HStack(spacing: 6) {
            Text("—")
            Text(text)
        }
        .font(.system(size: Theme.labelSize, design: .monospaced))
        .foregroundColor(Theme.textMuted)
        .textCase(.uppercase)
        .tracking(1.5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
