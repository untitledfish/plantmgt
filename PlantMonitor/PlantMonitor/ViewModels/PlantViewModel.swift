import SwiftUI
import Combine

@MainActor
class PlantViewModel: ObservableObject {
    @Published var plant: PlantData
    @Published var isLive: Bool = true
    @Published var lastUpdated: Date = Date()

    private var timer: AnyCancellable?

    init() {
        // ── Mock seed data ──
        self.plant = PlantData(
            name: "Monstera",
            species: "deliciosa",
            potID: "POT 01",
            temperature: 23.0,
            humidity: 61.0,
            phCurrent: 6.4,
            phTargetLow: 6.0,
            phTargetHigh: 6.8,
            reservoirLevel: 68.0,
            soilMoisture: 74.0,
            lastWatered: Calendar.current.date(bySettingHour: 7, minute: 22, second: 0, of: Date()) ?? Date()
        )
        startSimulation()
    }

    // ── Simulate live sensor fluctuations ──
    // When I have real hardware, replace this timer body with the
    // network/BLE fetch and assign results to `self.plant`.
    func startSimulation() {
        timer = Timer.publish(every: 3.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                self.plant.temperature  = (self.plant.temperature  + Double.random(in: -0.3...0.3)).clamped(to: 18...32)
                self.plant.humidity     = (self.plant.humidity     + Double.random(in: -1.0...1.0)).clamped(to: 30...90)
                self.plant.phCurrent    = (self.plant.phCurrent    + Double.random(in: -0.05...0.05)).clamped(to: 5.0...8.0)
                self.plant.soilMoisture = (self.plant.soilMoisture + Double.random(in: -0.5...0.2)).clamped(to: 0...100)
                self.plant.reservoirLevel = (self.plant.reservoirLevel - Double.random(in: 0...0.1)).clamped(to: 0...100)
                self.lastUpdated = Date()
            }
    }

    func stopSimulation() {
        timer?.cancel()
        timer = nil
    }

    // ── Placeholder: connect to real data source ──
    // func connectToMQTT(host: String, topic: String) { … }
    // func connectToREST(url: URL, pollInterval: TimeInterval) { … }
}

// Convenience clamp
extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
