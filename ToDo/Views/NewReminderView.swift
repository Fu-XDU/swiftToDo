//
//  NewReminderView.swift
//  ToDo
//
//  Created by 付铭 on 2022/8/2.
//

import SwiftUI

struct NewReminderView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Binding var showNewReminderSheet: Bool

    @State var askBeforeCancel: Bool = false
    @State private var showActionSheet = false

    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var notesPlaceholder: String = "Notes"

//    init() {
//        UITableView.appearance().sectionFooterHeight = 1
//        UITableView.appearance().sectionHeaderHeight = 1
//    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            ZStack {
                if notes.isEmpty {
                    TextEditor(text: $notesPlaceholder)
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .disabled(true)
                }
                TextEditor(text: $notes)
                        .frame(height: 100)
            }
                    .padding(.leading, -4)
            Section {
                NavigationLink(destination: EmptyView()) {
                    Text("Details")
                }
            }

            Section {
                NavigationLink(destination: EmptyView()) {
                    HStack {
                        Text("List")
                        Spacer()
                        taskViewModel.allLists[0].iconColor.clipShape(Circle()).frame(width: 8, height: 8)
                        Text(taskViewModel.allLists[0].name).foregroundColor(Color.gray)
                    }
                }
            }
        }
                .navigationBarTitle("New Reminder", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            if (!title.isEmpty || !notes.isEmpty || askBeforeCancel) {
                                showActionSheet = true
                            } else {
                                showNewReminderSheet = false
                            }
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
//                            showingAddListSheet = false
//                            saveList()
                        } label: {
                            Text("Add")
                        }
                                .disabled(title.isEmpty)
                    }
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
                                    showNewReminderSheet = false
                                }
//                                    .default(
//                                            Text("Append to Current Workout")
//                                    ) {
//                                        print("123")
//                                    }
                            ]
                    )
                }
                .padding(.top, -70)
                .environment(\.defaultMinListRowHeight, 55).environment(\.defaultMinListHeaderHeight, 0) // HERE
    }
}

//struct NewReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewReminderView()
//    }
//}
