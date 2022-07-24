//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    let spacing: CGFloat = 20

    @State private var isExpanded = true
    @State private var input = ""
    @State private var showNew = false

    init() {
    }

    var body: some View {
        List {
            Section {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                    Card()
                    Card()
                    Card()
                })
            }.listRowBackground(Color("CardBackground"))


            Section(header: Text("My Lists")) {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    Text("8")
                }
            }
        }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("", displayMode: .inline)
    }
}
