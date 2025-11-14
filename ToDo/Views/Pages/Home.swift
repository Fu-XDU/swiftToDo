//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

// MARK: - Constants
private enum Constants {
    static let rowHeight: CGFloat = 40
    static let cardHeight: CGFloat = 83
    static let cardSpacing: CGFloat = 15
    static let cardTopPadding: CGFloat = 5
    static let iconSize: CGFloat = 21
    static let cardIconSize: CGFloat = 18
    static let listIconSize: CGFloat = 16
    static let sectionHeaderFontSize: CGFloat = 22
    static let toolbarIconSize: CGFloat = 25
    static let itemCountGray = Color(red: 0.55, green: 0.55, blue: 0.55)

    // Section header 内边距
    static let sectionHeaderInsets = EdgeInsets(top: 0, leading: 10, bottom: 4, trailing: 0)
}

// MARK: - CardRow View
struct CardRow: View {
    @Binding var card: CardModel

    var body: some View {
        HStack {
            Image(systemName: card.selected ? "checkmark.circle.fill" : "circle")
                .font(.system(size: Constants.iconSize))
                .foregroundColor(.blue)
            CustomIcon(
                icon: card.icon,
                iconColor: card.iconColor,
                iconFont: .system(size: Constants.cardIconSize, weight: .bold),
                iconPadding: 7
            )
            Text(card.title)
            Spacer()
        }
        .frame(height: Constants.rowHeight)
        .contentShape(Rectangle())
        .onTapGesture { card.selected.toggle() }
    }
}

// MARK: - ListRow View
struct ListRow: View {
    let list: ListModel
    let isEditMode: Bool

    var body: some View {
        HStack {
            CustomIcon(
                icon: list.icon,
                iconColor: list.iconColor,
                iconFont: .system(size: Constants.listIconSize, weight: .bold),
                iconPadding: 9
            )
            .padding(.leading, -10)
            Text(list.name)
            Spacer()
            if isEditMode {
                Image(systemName: "info.circle")
                    .foregroundColor(.blue)
                    .font(.system(size: Constants.iconSize))
            } else {
                Text("\(list.items.count)")
                    .foregroundColor(Constants.itemCountGray)
            }
        }
    }
}

// MARK: - Home View
struct Home: View {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State var isEditMode: EditMode = .inactive
    @State private var showingAddListSheet = false
    @State private var showingNewReminderSheet = false
    @State private var searchText: String = ""

    init() {
    }

    var body: some View {
        NavigationView {
            ScrollView {
                if isEditMode != .active {
                    cardsGridView
                } else {
                    cardsEditView
                        .padding(EdgeInsets(top: -30, leading: 0, bottom: -25, trailing: 0))
                }
                List {
                    listsSection
                }
                .padding(.top, 5)
                .frame(height: 100)
            }.listStyle(InsetGroupedListStyle())
                .listRowInsets(EdgeInsets())
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
                .environment(\.editMode, $isEditMode)
                .searchable(
                    text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "搜索"
                ).toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        bottomToolbarContent
                    }
                }
                .background(Color("CardBackground"))
        }
    }

    // MARK: - Cards Grid View
    private var cardsGridView: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: Constants.cardSpacing),
                GridItem(.flexible()),
            ],
            alignment: .center,
            spacing: Constants.cardSpacing
        ) {
            ForEach($taskViewModel.cards, id: \.id) { $card in
                if card.selected {
                    Button {
                        // TODO: 添加卡片点击导航功能
                    } label: {
                        Card(card: card).height(Constants.cardHeight)
                    }
                    .contextMenu {
                        Section("全部") {
                            Button {
                            } label: {
                                Label("隐藏", systemImage: "eye.slash")
                            }
                        }

                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, Constants.cardTopPadding)
    }

    // MARK: - Cards Edit View
    private var cardsEditView: some View {
        List {
            ForEach($taskViewModel.cards, id: \.id) { $card in
                CardRow(card: $card)
            }
            .onMove(perform: moveCards)
            .buttonStyle(PlainButtonStyle())
            .frame(height: Constants.rowHeight)
        }
        .frame(height: 430)
    }

    // MARK: - Lists Section
    private var listsSection: some View {
        Section(
            header: HStack {
                Text("我的列表")
                    .font(
                        .system(
                            size: Constants.sectionHeaderFontSize, weight: .bold, design: .rounded)
                    )
                    .foregroundColor(Color("PureBlack"))
                Spacer()
            }
            .listRowInsets(Constants.sectionHeaderInsets)
        ) {
            ForEach(taskViewModel.lists, id: \.id) { list in
                if isEditMode == .active {
                    // 编辑模式下不显示箭头，直接显示内容
                    ListRow(list: list, isEditMode: true)
                } else {
                    // 非编辑模式下显示 NavigationLink（带箭头）
                    NavigationLink(
                        destination: ListDetailView(),
                        label: {
                            ListRow(list: list, isEditMode: false)
                        }
                    )
                }
            }
            .onDelete(perform: deleteLists)
            .onMove(perform: moveLists)
            .frame(height: Constants.rowHeight)

        }
        .textCase(nil)
    }

    // MARK: - Bottom Toolbar Content
    @ViewBuilder
    private var bottomToolbarContent: some View {
        if isEditMode != .active {
            Button {
                showingNewReminderSheet = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: Constants.toolbarIconSize))
                        .foregroundColor(
                            taskViewModel.lists.isEmpty ? Color.gray : Color.blue
                        )
                    Text("New Reminder")
                        .bold()
                }
            }
            .disabled(taskViewModel.lists.isEmpty)
            .sheet(isPresented: $showingNewReminderSheet) {
                NavigationView {
                    NewReminderView(showNewReminderSheet: $showingNewReminderSheet)
                        .environmentObject(taskViewModel)
                }
            }
        } else {
            Button {
                showingNewReminderSheet = true
            } label: {
                Text("Add Group")
            }
            .disabled(taskViewModel.lists.isEmpty)
        }

        Spacer()

        Button {
            showingAddListSheet = true
        } label: {
            Text("Add List")
        }
        .sheet(isPresented: $showingAddListSheet) {
            NavigationView {
                AddListView(showingAddListSheet: $showingAddListSheet)
                    .environmentObject(taskViewModel)
            }
        }
    }

    // MARK: - Helper Functions
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
        Home()
            .ignoresSafeArea()
    }
}
