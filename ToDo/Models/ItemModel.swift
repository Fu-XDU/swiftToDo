//
// Created by 付铭 on 2022/7/15.
//

import Foundation

struct ItemModel: Identifiable {
    let id = UUID()
    var title: String
    var done: Bool
    var favorite: Bool

    init() {
        title = "test"
        done = false
        favorite = false
    }

    init(title: String, done: Bool, favorite: Bool) {
        self.title = title
        self.done = done
        self.favorite = favorite
    }

    init(done: Bool, favorite: Bool) {
        title = "test"
        self.done = done
        self.favorite = favorite
    }

    mutating func changeFavorite() {
        favorite = !favorite
    }

    mutating func changeDone() {
        done = !done
    }
}