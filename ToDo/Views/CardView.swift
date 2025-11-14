//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct Card: View {
    var height: CGFloat = 80
    var icon: String = "calendar.circle.fill"
    var title: String = "Title"
    var iconColor: Color = Color.blue
    var taskCount: Int = 0

    init(card: CardModel) {
        icon = card.icon
        iconColor = card.iconColor
        title = card.title
        taskCount = card.count
    }

    init(icon: String, iconColor: Color, title: String, taskCount: Int) {
        self.icon = icon
        self.iconColor = iconColor
        self.title = title
        self.taskCount = taskCount
    }

    func height(_ value: CGFloat) -> Card {
        var copy = self
        copy.height = value
        return copy
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CustomIcon(icon: icon, iconColor: iconColor, iconFont: .system(size: 18, weight: .regular), iconPadding: 7)
                Spacer()
                Text("\(taskCount)")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(Color("PureBlack"))
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 20))
            Text(title)
                .font(.system(size: 17, weight: .semibold, design: .rounded))
                .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.55))
                .padding(EdgeInsets(top: 0, leading: 13, bottom: 0, trailing: 0))
        }
        .frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .topLeading)
        .background(Color("listBackground"))
        .cornerRadius(10)
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        let taskViewModel = TaskViewModel()
        NavigationView {
            List {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], alignment: .center, spacing: 15, content: {
                    ForEach(taskViewModel.cards, id: \.id) { card in
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
            }
        }
    }
}
