//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

// https://stackoverflow.com/users/8561936/ammar-ahmad

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State var isEditMode: EditMode = .inactive
    @State private var refresh = UUID()

    init() {
    }

    var body: some View {
        List {
            if (isEditMode != .active) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                    ForEach(0..<taskViewModel.selectedCards.count - (taskViewModel.selectedCards.count % 2 == 0 ? 0 : 1), id: \.self) { i in
                        Button {
                        } label: {
                            Card(card: taskViewModel.selectedCards[i])
                        }
                                .padding(i % 2 == 0 ? .leading : .trailing, -20)
                    }

                    if (taskViewModel.selectedCards.count % 2 == 1) {
                        Button {
                        } label: {
                            Card(card: taskViewModel.selectedCards[taskViewModel.selectedCards.count - 1])
                        }
                                .frame(width: 373).padding(.trailing, -175)
                    }
                })
                        .padding(.top, 5)
                        .buttonStyle(BorderlessButtonStyle())
                        .listRowBackground(Color("CardBackground"))
            } else {
                ForEach(taskViewModel.cards.indices, id: \.self) { i in
                    HStack {
                        Button {
                            print("1234")
                            taskViewModel.cards[i].selected = !taskViewModel.cards[i].selected
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 21))
                                    .foregroundColor(taskViewModel.cards[i].selected ? Color.blue : Color.red)
                                    .padding(.leading, -45)
                        }

                        CustomIcon(icon: taskViewModel.cards[i].icon, iconColor: taskViewModel.cards[i].iconColor, iconFont: .system(size: 18, weight: .bold), iconPadding: 7)
                                .padding(.leading, -18)
                        Text(taskViewModel.cards[i].title)
                    }
                }
                        .onMove { (v: IndexSet, i: Int) in
                            print("\(v) \(i)")
                        }
                        .frame(height: 45)
            }

            Section(header: Text("My Lists").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color("PureWhite")).padding(.leading, 10)) {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView().onAppear {
                        refresh = UUID()
                    }, label: {
                        HStack {
                            CustomIcon(icon: "list.bullet", iconColor: Color.blue, iconFont: .system(size: 16, weight: .bold), iconPadding: 9)
                                    .padding(.leading, -10)
                            Text("Title")
                            Spacer()
                            if (isEditMode == .active) {
                                Image(systemName: "info.circle")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 22))
                            } else {
                                Text("0").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                            }
                        }
                    })
                }
                        .onDelete { index in
                            print("\(index)")
                        }
                        .onMove { (v: IndexSet, i: Int) in
                            print("\(v) \(i)")
                        }
                        .frame(height: 45)
            }
                    .textCase(nil)
        }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
                .environment(\.editMode, $isEditMode)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        if (isEditMode != .active) {
                            Button {
                                print("Pressed")
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 25))
                                            .foregroundColor(Color.blue)
                                    Text("New Reminder")
                                            .bold()
                                }
                            }
                        } else {
                            Button {
                                print("Pressed")
                            } label: {
                                HStack {
                                    Text("Add Group")
                                }
                            }
                        }
                        Spacer()
                        Button {
                            print("Pressed")
                        } label: {
                            HStack {
                                Text("Add List")
                            }
                        }
                    }
                }
                .id(refresh)
    }
}
