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
        var t = undoneItems[index]
        undoneItems.remove(at: index)
        t.done = true
        doneItems.insert(t, at: 0)
    }

    func itemUndone(index: Int) {
        var t = doneItems[index]
        doneItems.remove(at: index)
        t.done = false
        undoneItems.insert(t, at: 0)
    }

    func deleteRow(at offsets: IndexSet) {
        undoneItems.remove(atOffsets: offsets)
    }

    func addItem(title: String, done: Bool, favorite: Bool) {
        if (done) {
            doneItems.insert(ItemModel(title: title, done: done, favorite: favorite), at: 0)
        } else {
            undoneItems.insert(ItemModel(title: title, done: done, favorite: favorite), at: 0)
        }
    }

    func addItem(item: ItemModel) {
        addItem(title: item.title, done: item.done, favorite: item.favorite)
    }

    func updateItem(id: UUID, newItem: ItemModel) {
        var itemIndex = getDoneItem(id: id)
        var oldItemDone = true

        if (itemIndex == -1) {
            itemIndex = getUndoneItem(id: id)
            if (itemIndex == -1) {
                return
            }
            oldItemDone = false
        }

        if (oldItemDone) {
            doneItems[itemIndex].title = newItem.title
            doneItems[itemIndex].favorite = newItem.favorite
        } else {
            undoneItems[itemIndex].title = newItem.title
            undoneItems[itemIndex].favorite = newItem.favorite
        }


        if (oldItemDone != newItem.done) {
            if (oldItemDone) {
                itemUndone(index: itemIndex)
            } else {
                itemDone(index: itemIndex)
            }
        }
    }


    func getDoneItem(id: UUID) -> Int {
        getItemIndex(items: doneItems, id: id)
    }

    func getUndoneItem(id: UUID) -> Int {
        getItemIndex(items: undoneItems, id: id)
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
