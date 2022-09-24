import Foundation
import SwiftUI

class GoalDetailViewModel: ObservableObject {
    private var goalManager: GoalFirebaseManager
    var item = ""
    
    @Published var goal: Goal
    
    init(goal: Goal, goalManager: GoalFirebaseManager = GoalFirebaseManager()) {
        self.goalManager = goalManager
        self.goal = goal
    }
    
    func addItem(item: String) {
        guard let gid = goal.id else { return }
        Task {
            let newGoal = await goalManager.addItem(gid: gid, item: item)
            if let newGoal = newGoal {
                DispatchQueue.main.async {
                    self.goal = newGoal
                    self.item = ""
                }
            }
        }
    }
    
    func delete(item: String) {
        guard let gid = goal.id else { return }
        Task {
            let newGoal = await goalManager.deleteItem(gid: gid, item: item)
            if let newGoal = newGoal {
                DispatchQueue.main.async {
                    self.goal = newGoal
                }
            }
        }
    }
}
