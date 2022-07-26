//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

// https://stackoverflow.com/users/8561936/ammar-ahmad

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    let spacing: CGFloat = 20
    @GestureState var isDetectingLongPress = false

    init() {
    }

    var body: some View {
        List {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                Card().padding(.leading, -20)
                Card().padding(.trailing, -20)
                Card().padding(.leading, -20)
                Card().padding(.trailing, -20)
                Card().frame(width: 373).padding(.trailing, -175)
            })
                    .listRowBackground(Color("CardBackground"))

            Section(header: Text("My Lists").font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color("PureWhite")).padding(.leading, 10)) {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    NavigationLink(destination: ListDetailView(), label: {
                        HStack{
                            Image(systemName: "calendar.circle.fill").foregroundColor(Color.blue).font(.system(size: 35)).padding(.leading,-10)
                            Text("Title")
                            Spacer()
                            Text("0").foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                        }

                    })
                }.frame(height: 45)
            }
                    .textCase(nil)
        }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("", displayMode: .inline)
    }
}
