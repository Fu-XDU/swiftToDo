//
// Created by 付铭 on 2022/7/29.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Binding var showingAddListSheet: Bool
    @State var title: String = ""
    @State var askBeforeCancel: Bool = false
    @State private var showActionSheet = false

    var colors: [Color] = [.red, .orange, .yellow, .green, Color("systemCyan"), .blue, Color("systemIndigo"), .pink, .purple, Color("systemBrown")]
    var icons: [String] = ["list.bullet", "list.bullet", "mappin", "gift.fill", "", "graduationcap.fill", "", "", "", "book.fill", "", "creditcard.fill", "house.fill", "building.columns.fill", "building.2.fill", "gamecontroller.fill", "leaf.fill", "pills.fill", "shippingbox.fill", "cart.fill", "", "", "", "", "", "", "", "", "headphones", "leaf.fill", "", "", "", "", "", "", "", "", "", ""]
    var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var selectedColorIndex = 0
    @State var selectedIconIndex = 0
    @State var textFieldColor: Color = Color("textFieldUneditingBg")

    var body: some View {

        VStack {

            ZStack {
                Circle()
                        .fill(colors[selectedColorIndex])
                        .frame(height: 95)
                        .padding(5)

                Image(systemName: icons[selectedIconIndex])
                        .font(.system(size: 45, weight: .bold))
                        .foregroundColor(Color.white)
                        .padding(10)
                        .clipShape(Circle())
                        .padding(5)
            }
                    .padding()
                    .padding([.vertical], 10)
            //.shadow(color: Color.white, radius: 10)
            TextField("",
                    text: $title,
                    onEditingChanged: { (editingChanged) in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            textFieldColor = Color(editingChanged ? "textFieldEditingBg" : "textFieldUneditingBg")
                        }
                    },
                    onCommit: {
                        // print("onCommit::\($title)")
                    })
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(colors[selectedColorIndex])
                    .frame(height: 60)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.horizontal], 20)
                    .cornerRadius(10)
                    .background(RoundedRectangle(cornerRadius: 16).fill(textFieldColor))
                    .padding([.horizontal], 24)
                    .multilineTextAlignment(.center)

            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 15, content: {
                    ForEach(colors.indices, id: \.self) { i in
                        ZStack {
                            Circle()
                                    .fill(colors[i])
                                    .frame(height: 43)
                                    .onTapGesture(perform: {
                                        selectedColorIndex = i
                                        askBeforeCancel = true
                                    })
                                    .padding(5)

                            if selectedColorIndex == i {
                                Circle()
                                        .stroke(Color("colorCircle"), lineWidth: 3)
                            }
                        }

                    }
                })
                        .padding()

                LazyVGrid(columns: columns, alignment: .center, spacing: 15, content: {
                    ZStack {
                        Image(systemName: "face.smiling.fill")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(Color(red: 0.21, green: 0.51, blue: 1))
                                .padding(7)
                                .background(Color(red: 0.21, green: 0.51, blue: 1, opacity: 0.3))
                                .clipShape(Circle())

                    }
                    ForEach(icons.indices, id: \.self) { i in
                        ZStack {
                            Circle()
                                    .fill(Color.gray.opacity(0.13))
                                    .frame(height: 43)
                                    .padding(5)

                            Image(systemName: icons[i])
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(Color.white)
                                    .padding(7)
                                    .clipShape(Circle())
                                    .padding(5)

                            if selectedIconIndex == i {
                                Circle()
                                        .stroke(Color("colorCircle"), lineWidth: 3)
                            }
                        }
                                .onTapGesture(perform: {
                                    selectedIconIndex = i
                                    askBeforeCancel = true
                                })
                    }
                })
                        .padding()
                        .padding(.top, -20)
            }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                                title: Text("Save"),
                                //message: Text("Choose a destination for workout data"),
                                buttons: [
                                    .cancel(),
                                    .destructive(
                                            Text("Discard Changes")
                                    ) {
                                        showingAddListSheet = false
                                    }
//                                    .default(
//                                            Text("Append to Current Workout")
//                                    ) {
//                                        print("123")
//                                    }
                                ]
                        )
                    }
        }
                .navigationBarTitle("New List", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            if (title != "" || askBeforeCancel) {
                                showActionSheet = true
                            } else {
                                showingAddListSheet = false
                            }
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            showingAddListSheet = false
                            saveList()
                        } label: {
                            Text("Done")
                        }
                                .disabled(title == "")
                    }
                }
    }

    func saveList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            taskViewModel.addList(list: ListModel(name: title, icon: icons[selectedIconIndex], iconColor: colors[selectedColorIndex], items: []))
        }
    }
}
