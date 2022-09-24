import Foundation

struct Goal: Codable {
    var id: String?
    var name: String
    var tillDate: Date
    var color: String
    var icon: String
    var items: [String]
}

extension Goal {
    static func sampleGoals() -> [Goal] {
        return [
            Goal(id: UUID().uuidString, name: "Study", tillDate: Date(), color: "#00b894", icon: "📚", items: ["Learn 500 Italian Words", "Watch Youtube chennels"]),
            Goal(id: UUID().uuidString, name: "Wokrout", tillDate: Date(), color: "#fd79a8", icon: "🏊‍♂️", items: ["100 pull ups", "7km jogging"])
        ]
    }
}
