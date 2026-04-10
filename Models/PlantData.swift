import Foundation

struct PlantData: Equatable {
    var name: String
    var species: String          // e.g. "deliciosa"
    var potID: String            // e.g. "POT 01"

    // Live sensor readings
    var temperature: Double      // °C
    var humidity: Double         // %
    var phCurrent: Double
    var phTargetLow: Double
    var phTargetHigh: Double
    var reservoirLevel: Double   // % 0–100
    var soilMoisture: Double     // % 0–100
    var lastWatered: Date

    // Derived helpers
    var isPhInRange: Bool {
        phCurrent >= phTargetLow && phCurrent <= phTargetHigh
    }

    var phRangeLabel: String {
        String(format: "%.1f – %.1f", phTargetLow, phTargetHigh)
    }

    var lastWateredRelative: String {
        let diff = Date().timeIntervalSince(lastWatered)
        let hours = Int(diff / 3600)
        let minutes = Int((diff.truncatingRemainder(dividingBy: 3600)) / 60)
        if hours >= 24 {
            let days = hours / 24
            return "\(days)d ago"
        } else if hours > 0 {
            return "\(hours)h ago"
        } else {
            return "\(minutes)m ago"
        }
    }

    var lastWateredFormatted: String {
        let cal = Calendar.current
        let formatter = DateFormatter()
        if cal.isDateInToday(lastWatered) {
            formatter.dateFormat = "'Today,' h:mm a"
        } else if cal.isDateInYesterday(lastWatered) {
            formatter.dateFormat = "'Yesterday,' h:mm a"
        } else {
            formatter.dateFormat = "MMM d, h:mm a"
        }
        return formatter.string(from: lastWatered)
    }

    var soilMoistureLabel: String {
        switch soilMoisture {
        case 0..<30:  return "Dry"
        case 30..<55: return "Low"
        case 55..<75: return "Moist"
        default:      return "Saturated"
        }
    }

    var reservoirLabel: String {
        switch reservoirLevel {
        case 0..<20:  return "Critical"
        case 20..<40: return "Low"
        case 40..<70: return "Adequate"
        default:      return "Full"
        }
    }
}
