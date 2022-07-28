//
// Created by 付铭 on 2022/7/28.
//

import Foundation
import SwiftUI

struct CardModel: Identifiable {
    let id = UUID()
    var title: String
    var count: Int
    var icon: String
    var iconColor: Color
    var selected: Bool
}
