import SwiftUI

enum Tab: CaseIterable {
    case monitor, history, alerts, settings

    var icon: String {
        switch self {
        case .monitor:  return "leaf.fill"
        case .history:  return "chart.line.uptrend.xyaxis"
        case .alerts:   return "bell.fill"
        case .settings: return "gearshape.fill"
        }
    }

    var label: String {
        switch self {
        case .monitor:  return "Monitor"
        case .history:  return "History"
        case .alerts:   return "Alerts"
        case .settings: return "Settings"
        }
    }
}

struct ForestTabBar: View {
    @Binding var selected: Tab

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selected = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 18))
                            .foregroundColor(selected == tab ? Theme.accent : Theme.textMuted)
                            .shadow(color: selected == tab ? Theme.accent : .clear, radius: 4)
                            .scaleEffect(selected == tab ? 1.1 : 1.0)

                        if selected == tab {
                            Circle()
                                .fill(Theme.accent)
                                .frame(width: 4, height: 4)
                                .shadow(color: Theme.accent, radius: 3)
                                .transition(.scale.combined(with: .opacity))
                        } else {
                            Circle()
                                .fill(.clear)
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 28)
        .background(
            Theme.navBackground
                .overlay(
                    Rectangle()
                        .fill(Theme.cardBorder)
                        .frame(height: 1),
                    alignment: .top
                )
        )
        .background(.ultraThinMaterial)
    }
}
