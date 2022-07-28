//
// Created by 付铭 on 2022/7/25.
//

import SwiftUI

struct ListDetailView: View {
    var body: some View {
        Text("12")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button {
                            print("Pressed")
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 25))
                                        .foregroundColor(Color.blue)
                                Text("New Reminder")
                                        .bold()
                            }
                        }
                        Spacer()
                    }
                }
    }
}
