import SwiftUI

struct GoalView: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
            
            Text(goal.tillDate.toRelativeDate())
            
            HStack(alignment: .bottom) {
                Text("\(goal.items.count) items")
                    .padding(.top, 20)
                Spacer()
                Text(goal.icon)
                    .font(.largeTitle)
            }
        }.foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor(hex: goal.color))) 
            )
    }
}
