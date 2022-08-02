//
// Created by 付铭 on 2022/7/15.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var selectedCards: [CardModel] = []
    @Published var allLists: [ListModel] = []

    init() {
        getItems()
    }


    func getSelectedItems() -> [CardModel] {
        var newCardItems: [CardModel] = []
        for item in cards {
            if (item.selected) {
                newCardItems.append(item)
            }
        }
        return newCardItems
    }

    func getItems() {
        let newCardItems = [
            // Use "Note" with today date
            CardModel(title: "Today", count: 0, icon: "note.text", iconColor: Color.blue, selected: true),
            CardModel(title: "Scheduled", count: 0, icon: "calendar", iconColor: Color.red, selected: true),
            CardModel(title: "All", count: 0, icon: "tray.fill", iconColor: Color(red: 0.36, green: 0.38, blue: 0.41), selected: true)
        ]
        cards.append(contentsOf: newCardItems)

        let newListItems = [
            // Use "Note" with today date
            ListModel(name: "hello", icon: "note.text", iconColor: Color.blue, items: [])
        ]
        allLists.append(contentsOf: newListItems)

        updateSelectedCardsList()
    }

    func updateSelectedCardsList() {
        selectedCards = []
        for item in cards {
            if (item.selected) {
                selectedCards.append(item)
            }
        }
    }

    func addList(list: ListModel) {
        allLists.append(list)
    }


    func getItemIndex(items: [ItemModel], id: UUID) -> Int {
        var i = 0;
        for item in items {
            if (item.id == id) {
                return i
            }
            i += 1
        }
        return -1
    }
}
