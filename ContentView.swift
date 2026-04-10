import SwiftUI

struct ContentView: View {
    @StateObject private var vm = PlantViewModel()
    @State private var selectedTab: Tab = .monitor

    var body: some View {
        ZStack(alignment: .bottom) {

            // ── Background ──
            Theme.background
                .ignoresSafeArea()

            // ── Ambient glow (behind content) ──
            ForestBackgroundGlow()
                .ignoresSafeArea()

            // ── Tab Content ──
            VStack(spacing: 0) {
                // Top safe area spacer (below Dynamic Island / notch)
                Color.clear.frame(height: 0)

                switch selectedTab {
                case .monitor:
                    MonitorView(vm: vm)
                        .transition(.opacity)
                case .history:
                    HistoryView()
                        .transition(.opacity)
                case .alerts:
                    AlertsView()
                        .transition(.opacity)
                case .settings:
                    SettingsView(vm: vm)
                        .transition(.opacity)
                }

                // Spacer so content doesn't hide behind tab bar
                Color.clear.frame(height: 74)
            }
            .animation(.easeInOut(duration: 0.2), value: selectedTab)

            // ── Tab Bar ──
            ForestTabBar(selected: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
