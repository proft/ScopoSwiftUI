import SwiftUI

struct GoalDetailView: View {
    @ObservedObject var vm = GoalDetailViewModel(goal: Goal.sampleGoals()[1])
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.goal.name)
                        .font(.title)
                        .bold()
                    Spacer()
                    Text(vm.goal.icon)
                }
                
                Text("Due: \(vm.goal.tillDate.toRelativeDate())")
                    .padding(.vertical)
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(LinearGradient(
                colors: [
                    Color(UIColor(hex: vm.goal.color)),
                    Color(UIColor(hex: vm.goal.color)).opacity(0.6)
                ],
                startPoint: .top,
                endPoint: .bottom))
                
            List {
                HStack {
                    TextField("Enter goal", text: $vm.item)
                        .onSubmit {
                            vm.addItem(item: vm.item)
                        }
                        .submitLabel(.return)
                }
                
                ForEach(vm.goal.items, id: \.self) { item in
                    Text(item)
                }.onDelete { indexSet in
                    for indx in indexSet {
                        vm.delete(item: vm.goal.items[indx])
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView()
    }
}
