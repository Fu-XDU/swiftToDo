//
// Created by 付铭 on 2022/7/29.
//

import Foundation
import SwiftUI

struct ListModel: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
    var iconColor: Color
    var items: [ItemModel]
}
