import Foundation

@MainActor
class GoalListViewModel: ObservableObject {
    private var goalManager: GoalFirebaseManager
    
    @Published var goals = [Goal]()
    
    init(goalManager: GoalFirebaseManager = GoalFirebaseManager()) {
        self.goalManager = goalManager
    }
    
    func fetchAll() async {
        goals = await goalManager.fetchAll()
    }
    
    func delete(gid: String) {
        Task {
            await goalManager.delete(gid: gid)
        }
    }
}
