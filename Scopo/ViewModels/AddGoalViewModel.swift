import Foundation
import SwiftUI

@MainActor
class AddGoalViewModel: ObservableObject {
    private var goalManager: GoalFirebaseManager
    
    var name: String = ""
    var date = Date()
    var color = Color.pink
    var icon = "⭐️"
    var goal = ""
    
    @Published var items: [String] = []
    
    init(goalManager: GoalFirebaseManager = GoalFirebaseManager()) {
        self.goalManager = goalManager
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        items.append(item)
        goal = ""
    }
    
    func add() {
        let item = Goal(name: name, tillDate: date, color: UIColor(color).hexString(), icon: icon, items: items)
        
        Task {
            try? await goalManager.add(goal: item)
        }
    }
}
