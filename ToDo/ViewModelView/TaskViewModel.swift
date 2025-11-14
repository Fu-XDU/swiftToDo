//
// Created by 付铭 on 2022/7/15.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var lists: [ListModel] = []

    init() {
        let newCardItems = [
            // Use "Note" with today date
            CardModel(title: "今天", count: 0, icon: "note.text", iconColor: Color.blue, selected: true),
            CardModel(title: "计划", count: 0, icon: "calendar", iconColor: Color.red, selected: true),
            CardModel(title: "全部", count: 0, icon: "tray.fill", iconColor: Color.gray, selected: true),
            CardModel(title: "旗标", count: 0, icon: "flag.fill", iconColor: Color.yellow, selected: true),
            CardModel(title: "完成", count: 0, icon: "checkmark", iconColor: Color.gray, selected: true),
            CardModel(title: "分配给我", count: 0, icon: "person.fill", iconColor: Color.green, selected: true),
        ]
        cards.append(contentsOf: newCardItems)

        let newListItems = [
            // Use "Note" with today date
            ListModel(name: "hello", icon: "note.text", iconColor: Color.blue, items: []),
        ]
        lists.append(contentsOf: newListItems)
    }

    func addList(list: ListModel) {
        lists.append(list)
    }

    func addReminder(listIndex: Int, reminder: ItemModel) {
        lists[listIndex].items.append(reminder)
    }
}
