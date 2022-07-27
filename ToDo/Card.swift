//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct Card: View {
    let height: CGFloat = 81
    @GestureState var isDetectingLongPress = false
    var icon: String = "calendar.circle.fill"
    var title: String = "Title"
    var iconColor: Color = Color.blue
    var taskCount: Int = 0

    init(icon: String, iconColor: Color, title: String, taskCount: Int) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.taskCount = taskCount
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
        VStack(alignment: .leading) {
            HStack {
                CustomIcon(icon: icon, iconColor: iconColor, iconFont: .system(size: 18, weight: .regular), iconPadding: 7)
                Spacer()
                Text("\(taskCount)")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 20))
            }
                    .padding(EdgeInsets(top: 7, leading: 10, bottom: 0, trailing: 0))
            Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                    .padding(EdgeInsets(top: 3, leading: 13, bottom: 0, trailing: 0))
            Spacer()
        }
                .background(Color("listBackground"))
                .cornerRadius(10)
                .frame(height: height)
                .opacity(isDetectingLongPress ? 0.5 : 1).gesture(longPress)
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        Card(icon: "calendar.circle.fill", iconColor: Color.blue, title: "Title", taskCount: 0)
    }
}
