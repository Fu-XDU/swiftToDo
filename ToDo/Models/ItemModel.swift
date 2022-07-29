//
// Created by 付铭 on 2022/7/15.
//

import Foundation

struct ItemModel: Identifiable {
    let id = UUID()
    var title: String
    var done: Bool
    var notes: String

    init() {
        title = ""
        done = false
        notes = ""
    }

    init(title: String, done: Bool, notes: String) {
        self.title = title
        self.done = done
        self.notes = notes
    }
}