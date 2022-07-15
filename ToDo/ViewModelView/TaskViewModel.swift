//
// Created by 付铭 on 2022/7/15.
//

import Foundation

class TaskViewModel: ObservableObject {

    @Published var doneItems: [ItemModel] = []
    @Published var undoneItems: [ItemModel] = []

    init() {
        getItems()
    }

    func getItems() {
        let newDoneItems = [
            ItemModel(title: "向学校部署新后台", done: true, favorite: true),
            ItemModel(title: "test7", done: true, favorite: true),
            ItemModel(title: "test8", done: true, favorite: false),
            ItemModel(title: "test9", done: true, favorite: false),
            ItemModel(title: "test10", done: true, favorite: false),
        ]
        doneItems.append(contentsOf: newDoneItems)

        let newUndoneItems = [
            ItemModel(title: "向学校部署新后台", done: false, favorite: true),
            ItemModel(title: "test2", done: false, favorite: true),
            ItemModel(title: "test3", done: false, favorite: false),
            ItemModel(title: "test4", done: false, favorite: false),
            ItemModel(title: "test5", done: false, favorite: false),

        ]
        undoneItems.append(contentsOf: newUndoneItems)
    }

    func itemDone(index: Int) {
        let t = undoneItems[index]
        undoneItems.remove(at: index)
        doneItems.insert(t, at: 0)
    }

    func itemUndone(index: Int) {
        let t = doneItems[index]
        doneItems.remove(at: index)
        undoneItems.insert(t, at: 0)
    }

    func deleteRow(at offsets: IndexSet) {
        undoneItems.remove(atOffsets: offsets)
    }
}
