import SwiftUI

struct AddNewGoalView: View {
    @StateObject private var vm = AddGoalViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section {
                        TextField("Name", text: $vm.name)
                        
                        DatePicker(
                            selection: $vm.date,
                            in: Date()...,
                            displayedComponents: .date) {
                                Text("Select goal due date")
                            }
                            .id(vm.date)
                        
                        ColorPicker("Select goal color", selection: $vm.color)
                        
                        EmojiTextField(text: $vm.icon, placeholder: "Enter emoji icon")
                    }
                }.frame(maxHeight: 200)
                
                List {
                    HStack {
                        TextField("Enter goal", text: $vm.goal)
                            .onSubmit {
                                vm.addItem(item: vm.goal)
                            }
                            .submitLabel(.return)
                    }
                    
                    ForEach(vm.items, id: \.self) { item in
                        Text(item)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("New Goal")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            vm.add()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Save")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
}

struct AddNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalView()
    }
}
