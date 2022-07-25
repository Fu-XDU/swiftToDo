//
// Created by 付铭 on 2022/7/23.
//

import SwiftUI

struct Home: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    let spacing: CGFloat = 20
    @GestureState var isDetectingLongPress = false

    init() {
    }

    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1000)
                .updating($isDetectingLongPress) { currentState, gestureState,
                                                   transaction in
                    gestureState = currentState
                    transaction.animation = Animation.easeIn(duration: 0.1)
                }
    }
    var body: some View {

        Form {

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                    Card().opacity(isDetectingLongPress ? 0.5 : 1).gesture(longPress)
                    Card()
                    Card()
                })
                        .listRowBackground(Color("CardBackground"))

                    .listStyle(InsetGroupedListStyle())


            Section(header: Text("My Lists")) {
                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                    Button {
                    } label: {
                        Text("8")
                    }
                }
            }
        }.navigationBarTitle("", displayMode: .inline)

    }
}
