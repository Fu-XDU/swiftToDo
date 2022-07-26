//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

// https://stackoverflow.com/users/8561936/ammar-ahmad

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State var isEditMode: EditMode = .inactive
    @State var selectedItems: Set<String> = Set<String>()

    let spacing: CGFloat = 20
    @GestureState var isDetectingLongPress = false

    init() {
    }

    var body: some View {
        List {
            if (isEditMode == .inactive) {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                    Card().padding(.leading, -20)
                    Card().padding(.trailing, -20)
                    Card().padding(.leading, -20)
                    Card().padding(.trailing, -20)
                    Card().frame(width: 373).padding(.trailing, -175)
                })
                        .padding(.top, 5)
                        .listRowBackground(Color("CardBackground"))
            } else {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView(), label: {
                        HStack {
                            Image(systemName: "calendar.circle.fill").foregroundColor(Color.blue).font(.system(size: 35)).padding(.leading, -10)
                            Text("Title")
                            Spacer()
                            Text("0").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                        }
                    })
                }
                        .onMove { (v: IndexSet, i: Int) in
                            print("\(v) \(i)")
                        }
                        .frame(height: 45)
                //.animation(Animation.easeInOut(duration: 1.0))

            }

            Section(header: Text("My Lists").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color("PureWhite")).padding(.leading, 10)) {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView(), label: {
                        HStack {
                            Image(systemName: "calendar.circle.fill").foregroundColor(Color.blue).font(.system(size: 35)).padding(.leading, -10)
                            Text("Title")
                            Spacer()
                            Text("0").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
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

    }
}
