import SwiftUI

struct MonitorView: View {
    @ObservedObject var vm: PlantViewModel
    @State private var appeared = false

    var plant: PlantData { vm.plant }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // ── Plant Header ──────────────────────────
                VStack(alignment: .leading, spacing: 10) {
                    LiveBadge(potID: plant.potID)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(plant.name)
                            .font(.system(size: Theme.heroSize, design: .serif))
                            .foregroundColor(Theme.textPrimary)
                        Text(plant.species)
                            .font(.system(size: Theme.heroSize, design: .serif))
                            .italic()
                            .foregroundColor(Theme.accentSoft)
                    }
                }
                .padding(.horizontal, 22)
                .padding(.top, 16)
                .padding(.bottom, 24)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 12)
                .animation(.easeOut(duration: 0.5).delay(0.05), value: appeared)

                // ── Primary 2-col Stats ───────────────────
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        StatCard(
                            icon: "🌡️",
                            label: "Temp",
                            value: String(format: "%.1f", plant.temperature),
                            unit: "°C",
                            subtext: temperatureTrend,
                            isHighlighted: true
                        )
                        StatCard(
                            icon: "💧",
                            label: "Humidity",
                            value: String(format: "%.0f", plant.humidity),
                            unit: "%",
                            subtext: humidityLabel,
                            isHighlighted: false
                        )
                    }

                    // Full-width pH card
                    PHCard(
                        current: plant.phCurrent,
                        low: plant.phTargetLow,
                        high: plant.phTargetHigh
                    )
                }
                .padding(.horizontal, 22)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 16)
                .animation(.easeOut(duration: 0.5).delay(0.12), value: appeared)

                // ── Section Label ─────────────────────────
                SectionLabel(text: "Sensor Readings")
                    .padding(.horizontal, 22)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.18), value: appeared)

                // ── 3-col Mini Cards ──────────────────────
                HStack(spacing: 8) {
                    MiniStatCard(
                        icon: "🌱",
                        value: "\(Int(plant.soilMoisture))%",
                        label: "Soil\nMoisture"
                    )
                    MiniStatCard(
                        icon: "🪣",
                        value: "\(Int(plant.reservoirLevel))%",
                        label: "Reservoir\nLevel"
                    )
                    MiniStatCard(
                        icon: statusIcon,
                        value: statusText,
                        label: "Overall\nStatus"
                    )
                }
                .padding(.horizontal, 22)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(0.22), value: appeared)

                // ── Last Watered ──────────────────────────
                LastWateredRow(
                    formatted: plant.lastWateredFormatted,
                    relative: plant.lastWateredRelative
                )
                .padding(.horizontal, 22)
                .padding(.top, 10)
                .padding(.bottom, 28)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
                .animation(.easeOut(duration: 0.5).delay(0.28), value: appeared)

            }
        }
        .onAppear { appeared = true }
    }

    // ── Helpers ──

    private var temperatureTrend: String {
        let t = plant.temperature
        if t < 18 { return "↓ Below ideal" }
        if t > 28 { return "↑ Above ideal" }
        return "Within range"
    }

    private var humidityLabel: String {
        let h = plant.humidity
        if h < 40 { return "Too dry" }
        if h > 80 { return "Too humid" }
        return "Optimal range"
    }

    private var statusText: String {
        if !plant.isPhInRange { return "pH ⚠️" }
        if plant.reservoirLevel < 20 { return "Low 💧" }
        if plant.soilMoisture < 30  { return "Dry 🌵" }
        return "Good"
    }

    private var statusIcon: String {
        if !plant.isPhInRange || plant.reservoirLevel < 20 || plant.soilMoisture < 30 {
            return "⚠️"
        }
        return "✅"
    }
}
