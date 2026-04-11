import SwiftUI

struct ForestBackgroundGlow: View {
    @State private var pulse = false

    var body: some View {
        ZStack {
            // Top-left orb
            RadialGradient(
                colors: [Color(hex: "#226432").opacity(0.35), .clear],
                center: .center,
                startRadius: 0,
                endRadius: 180
            )
            .frame(width: 280, height: 280)
            .offset(x: -80, y: -160)
            .scaleEffect(pulse ? 1.1 : 1.0)
            .opacity(pulse ? 1.0 : 0.6)

            // Bottom-right orb
            RadialGradient(
                colors: [Color(hex: "#145028").opacity(0.25), .clear],
                center: .center,
                startRadius: 0,
                endRadius: 140
            )
            .frame(width: 200, height: 200)
            .offset(x: 100, y: 200)
            .scaleEffect(pulse ? 1.1 : 1.0)
            .opacity(pulse ? 0.9 : 0.5)
        }
        .animation(
            .easeInOut(duration: 4.0).repeatForever(autoreverses: true),
            value: pulse
        )
        .onAppear { pulse = true }
        .allowsHitTesting(false)
    }
}
