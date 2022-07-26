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
                Image(systemName: "calendar.circle.fill")
                        .foregroundColor(Color.blue)
                        .font(.system(size: 35))
                Spacer()
                Text("0")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .padding(EdgeInsets(top: -5, leading: 0, bottom: 0, trailing: 20))
            }
                    .padding(EdgeInsets(top: 7, leading: 10, bottom: 0, trailing: 0))
            Text("Title")
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
        Card()
    }
}
