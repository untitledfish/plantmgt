import SwiftUI

// ─── History Tab ───────────────────────────────────────────
struct HistoryView: View {
    var body: some View {
        PlaceholderView(icon: "chart.line.uptrend.xyaxis", title: "History", message: "Sensor trends and logs\nwill appear here.")
    }
}

// ─── Alerts Tab ────────────────────────────────────────────
struct AlertsView: View {
    var body: some View {
        PlaceholderView(icon: "bell.fill", title: "Alerts", message: "Threshold notifications\nwill appear here.")
    }
}

// ─── Settings Tab ──────────────────────────────────────────
struct SettingsView: View {
    @ObservedObject var vm: PlantViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Settings")
                    .font(.system(size: 28, design: .serif))
                    .foregroundColor(Theme.textPrimary)
                    .padding(.horizontal, 22)
                    .padding(.top, 20)

                // Plant info section
                VStack(alignment: .leading, spacing: 12) {
                    SectionLabel(text: "Plant Info")
                        .padding(.horizontal, 22)

                    SettingsRow(label: "Plant Name", value: vm.plant.name)
                    SettingsRow(label: "Species", value: vm.plant.species)
                    SettingsRow(label: "Pot ID", value: vm.plant.potID)
                }

                // pH targets section
                VStack(alignment: .leading, spacing: 12) {
                    SectionLabel(text: "pH Targets")
                        .padding(.horizontal, 22)

                    SettingsRow(label: "pH Low", value: String(format: "%.1f", vm.plant.phTargetLow))
                    SettingsRow(label: "pH High", value: String(format: "%.1f", vm.plant.phTargetHigh))
                }

                // Data source placeholder
                VStack(alignment: .leading, spacing: 12) {
                    SectionLabel(text: "Data Source")
                        .padding(.horizontal, 22)

                    SettingsRow(label: "Mode", value: "Mock / Simulated")
                    SettingsRow(label: "Refresh", value: "Every 3 seconds")
                }

                Spacer(minLength: 40)
            }
        }
    }
}

// ─── Shared Placeholder ────────────────────────────────────
struct PlaceholderView: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(Theme.accent.opacity(0.4))
            Text(title)
                .font(.system(size: 22, design: .serif))
                .foregroundColor(Theme.textPrimary)
            Text(message)
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(Theme.textMuted)
                .multilineTextAlignment(.center)
                .tracking(0.5)
            Spacer()
        }
    }
}

// ─── Settings Row ──────────────────────────────────────────
struct SettingsRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(Theme.textSecondary)
            Spacer()
            Text(value)
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(Theme.accentSoft)
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 12)
        .background(Theme.cardBackground)
        .overlay(
            Rectangle()
                .fill(Theme.cardBorder)
                .frame(height: 1),
            alignment: .bottom
        )
    }
}
