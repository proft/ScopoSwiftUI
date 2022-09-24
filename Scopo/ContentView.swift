import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = GoalListViewModel()
    @State private var isEditing = false
    @State private var showAddNewGoal = false
    
    var goalManager = GoalFirebaseManager()
    
    var goalItems: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    init() {
        Theme.navigationBarColors(bgColor: .clear, titleColor: .black, tintColor: .white)
    }

    func deleteButton(goal: Goal) -> some View {
        Button {
            guard let gid = goal.id else { return }
            
            isEditing = false
            vm.delete(gid: gid)
            Task {
                await vm.fetchAll()
            }
        } label: {
            Image(systemName: "minus.circle.fill")
        }
        .font(.title)
        .foregroundColor(isEditing ? .red : .clear)
        .offset(x: -90, y: -70)
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: goalItems, spacing: 10) {
                        ForEach(vm.goals, id: \.id) { goal in
                            NavigationLink(destination: GoalDetailView(vm: GoalDetailViewModel(goal: goal))) {
                                GoalView(goal: goal)
                                    .rotationEffect(.degrees(isEditing ? 2.5 : 0))
                                    .animation(Animation.easeInOut(duration: 0.12).repeat(while: isEditing), value: isEditing)
                                    .disabled(isEditing)
                                    .overlay(deleteButton(goal: goal))
                            }
                        }
                    }.padding(.horizontal)
                }
                .task {
                    await vm.fetchAll()
                }
                .navigationTitle("Goals")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isEditing.toggle()
                        } label: {
                            Text(isEditing ? "Done" : "Edit")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Button {
                    showAddNewGoal = true
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 64))
                        .shadow(radius: 5)
                        .clipped()
                        .foregroundColor((.blue))
                }
                .padding(.trailing, 20)
                .opacity(isEditing ? 0.0 : 1.0)
                .fullScreenCover(isPresented: $showAddNewGoal) {
                    Task {
                        await vm.fetchAll()
                    }
                } content: {
                    AddNewGoalView()
                }
            }
        }
    }
}
