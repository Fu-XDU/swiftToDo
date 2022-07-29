//
// Created by 付铭 on 2022/7/29.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Binding var showingAddListSheet: Bool
    @State var title: String = ""

    var body: some View {

        VStack {
            CustomIcon(icon: "list.bullet", iconColor: Color.blue, iconFont: .system(size: 45, weight: .bold), iconPadding: 28)
                    //.shadow(color: Color.white, radius: 10)
                    .padding()
            TextField("输入",
                    text: $title,
                    onEditingChanged: { isEditing in
                        //print("onEditingChanged::\($title)")
                    },
                    onCommit: {
                        //print("onCommit::\($title)")
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                    ForEach(0..<10) { element in
                        CustomIcon(icon: "list.bullet", iconColor: Color.blue, iconFont: .system(size: 20, weight: .bold), iconPadding: 4)
                    }
                })
            }
        }
                .navigationBarTitle("New List", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            showingAddListSheet = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showingAddListSheet = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                taskViewModel.addList(list: ListModel(name: title, icon: "list.bullet", iconColor: Color.blue, items: []))
                            }
                        } label: {
                            Text("Done")
                        }
                                .disabled(title == "")
                    }
                }

    }
}
