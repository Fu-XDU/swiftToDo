//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

struct CardRow: View {
    @Binding var card: CardModel

    var body: some View {
        HStack {
            Image(systemName: card.selected ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 21))
                .foregroundColor(.blue)
            CustomIcon(icon: card.icon, iconColor: card.iconColor, iconFont: .system(size: 18, weight: .bold), iconPadding: 7)
            Text(card.title)
            Spacer()
        }
        .frame(height: 45)
        .contentShape(Rectangle())
        .onTapGesture { card.selected.toggle() }
    }
}

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
            if isEditMode != .active {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                        ForEach($taskViewModel.cards, id: \.id) { $card in
                            if (card.selected){
                                Button {
                                } label: {
                                    Card(card: card).height(83)
                                }
                            }
                        }
                    })
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .padding(.top, 5)
//                    .padding(.top, 120)

            } else {
                // Bug: After deleting list below, here might render wrong
                ForEach($taskViewModel.cards, id: \.id) { $card in
                    CardRow(card: $card)
                }
                .onMove(perform: moveCards)
                .buttonStyle(PlainButtonStyle()) // I tried
                .frame(height: 45)
            }

            Section(header: Text("My Lists").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color("PureBlack"))) {
                ForEach(taskViewModel.lists.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView().onAppear {
                        refresh = UUID()
                    }, label: {
                        HStack {
                            CustomIcon(icon: taskViewModel.lists[i].icon, iconColor: taskViewModel.lists[i].iconColor, iconFont: .system(size: 16, weight: .bold), iconPadding: 9)
                                .padding(.leading, -10)
                            Text(taskViewModel.lists[i].name)
                            Spacer()
                            if isEditMode == .active {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 22))
                            } else {
                                Text("\(taskViewModel.lists[i].items.count)").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
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
                if isEditMode != .active {
                    Button {
                        showingNewReminderSheet = true
                    }
                            label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 25))
                                .foregroundColor(taskViewModel.lists.count == 0 ? Color.gray : Color.blue)
                            Text("New Reminder")
                                .bold()
                        }
                    }
                    .disabled(taskViewModel.lists.count == 0)
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
                    .disabled(taskViewModel.lists.count == 0)
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
    }

    func moveLists(from source: IndexSet, to destination: Int) {
        taskViewModel.lists.move(fromOffsets: source, toOffset: destination)
    }

    func deleteLists(at offsets: IndexSet) {
        taskViewModel.lists.remove(atOffsets: offsets)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        let compare: Bool = true
        if !compare {
            ZStack {
                Image("TempImage")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                CustomNavigationView(view: Home())
                    .ignoresSafeArea()
                    .opacity(0.5)
            }
        } else {
            CustomNavigationView(view: Home())
                .ignoresSafeArea()
        }
    }
}
