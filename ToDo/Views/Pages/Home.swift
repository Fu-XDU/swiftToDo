//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

// https://stackoverflow.com/users/8561936/ammar-ahmad

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State var isEditMode: EditMode = .inactive
    @State private var refresh = UUID()
    @State private var showingAddListSheet = false
    @State private var showingNewReminderSheet = false

    init() {
    }

    var body: some View {
        List {
            if (isEditMode != .active) {
                if (taskViewModel.selectedCards.count > 0) {
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
                }
            } else {
                // Bug: After deleting list below, here might render wrong
                ForEach(taskViewModel.cards.indices, id: \.self) { i in
                    Button {
                        taskViewModel.cards[i].selected.toggle()
                        taskViewModel.updateSelectedCardsList()
                    } label: {
                        HStack {
                            Image(systemName: taskViewModel.cards[i].selected ? "checkmark.circle.fill" : "circle")
                                    .font(.system(size: 21))
                                    .foregroundColor(Color.blue)
                                    .padding(.leading, -45)
                            CustomIcon(icon: taskViewModel.cards[i].icon, iconColor: taskViewModel.cards[i].iconColor, iconFont: .system(size: 18, weight: .bold), iconPadding: 7)
                                    .padding(.leading, -18)
                            Text(taskViewModel.cards[i].title)
                                    .foregroundColor(Color("PureWhite"))
                        }
                    }
                }
                        .onMove(perform: moveCards)
                        .buttonStyle(PlainButtonStyle()) // I tried
                        .frame(height: 45)
            }

            Section(header: Text("My Lists").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color("PureWhite")).padding(.leading, 10)) {
                ForEach(taskViewModel.allLists.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView().onAppear {
                        refresh = UUID()
                    }, label: {
                        HStack {
                            CustomIcon(icon: taskViewModel.allLists[i].icon, iconColor: taskViewModel.allLists[i].iconColor, iconFont: .system(size: 16, weight: .bold), iconPadding: 9)
                                    .padding(.leading, -10)
                            Text(taskViewModel.allLists[i].name)
                            Spacer()
                            if (isEditMode == .active) {
                                Image(systemName: "info.circle")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 22))
                            } else {
                                Text("\(taskViewModel.allLists[i].items.count)").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                            }
                        }
                    })
                }
                        .onDelete(perform: deleteLists)
                        .onMove(perform: moveLists)
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
                                showingNewReminderSheet = true
                            }
                            label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 25))
                                            .foregroundColor(taskViewModel.allLists.count == 0 ? Color.gray : Color.blue)
                                    Text("New Reminder")
                                            .bold()
                                }
                            }
                                    .disabled(taskViewModel.allLists.count == 0)
                                    .sheet(isPresented: $showingNewReminderSheet) {
                                        NavigationView {
                                            NewReminderView(showNewReminderSheet: $showingNewReminderSheet).environmentObject(taskViewModel)
                                        }
                                    }
                        } else {
                            Button {
                                showingNewReminderSheet = true
                            } label: {
                                HStack {
                                    Text("Add Group")
                                }
                            }
                                    .disabled(taskViewModel.allLists.count == 0)
                        }
                        Spacer()
                        Button {
                            showingAddListSheet = true
                        } label: {
                            HStack {
                                Text("Add List")
                            }
                        }
                                .sheet(isPresented: $showingAddListSheet) {
                                    NavigationView {
                                        AddListView(showingAddListSheet: $showingAddListSheet).environmentObject(taskViewModel)
                                    }
                                }
                    }
                }
                .id(refresh)
    }

    func moveCards(from source: IndexSet, to destination: Int) {
        taskViewModel.cards.move(fromOffsets: source, toOffset: destination)
        taskViewModel.updateSelectedCardsList()
    }

    func moveLists(from source: IndexSet, to destination: Int) {
        taskViewModel.allLists.move(fromOffsets: source, toOffset: destination)
    }

    func deleteLists(at offsets: IndexSet) {
        taskViewModel.allLists.remove(atOffsets: offsets)
        //taskViewModel.updateSelectedCardsList()
    }

}
