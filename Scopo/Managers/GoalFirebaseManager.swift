import Foundation
import Firebase
import FirebaseFirestoreSwift

class GoalFirebaseManager {
    private let db = Firestore.firestore()
    
    func fetchAll() async -> [Goal] {
        let snapshot = try? await db.collection("goals").getDocuments()
        return snapshot?.documents.compactMap { document in
            var goal = try? document.data(as: Goal.self)
            if goal != nil {
                goal!.id = document.documentID
            }
            return goal
        } ?? []
    }
    
    func add(goal: Goal) async throws -> Goal? {
        do {
            let ref = try db.collection("goals").addDocument(from: goal)
            return try await ref.getDocument(as: Goal.self)
        } catch {
            return nil
        }
    }
    
    func addItem(gid: String, item: String) async -> Goal? {
        let ref = db.collection("goals").document(gid)
        
        do {
            try await ref.updateData(["items": FieldValue.arrayUnion([item])])
            return try await ref.getDocument(as: Goal.self)
        } catch {
            return nil
        }
    }
    
    func deleteItem(gid: String, item: String) async -> Goal? {
        let ref = db.collection("goals").document(gid)
        
        do {
            try await ref.updateData(["items": FieldValue.arrayRemove([item])])
            return try await ref.getDocument(as: Goal.self)
        } catch {
            return nil
        }
    }
    
    func delete(gid: String) async {
        try? await db.collection("goals").document(gid).delete()
    }
}
