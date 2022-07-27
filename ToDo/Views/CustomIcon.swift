//
// Created by 付铭 on 2022/7/27.
//

import SwiftUI

struct CustomIcon: View {
    var icon: String = "calendar"
    var iconColor: Color = Color.blue
    var iconSize: CGFloat = 18
    var iconPadding: CGFloat = 7
    var iconFont: Font = .system(size: 18, weight: .regular)

    init(icon: String, iconColor: Color, iconFont: Font, iconPadding: CGFloat) {
        self.icon = icon
        self.iconColor = iconColor
        self.iconPadding = iconPadding
        self.iconFont = iconFont
    }

    var body: some View {
        Image(systemName: icon)
                .font(iconFont)
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: iconPadding, leading: iconPadding, bottom: iconPadding, trailing: iconPadding))
                .background(iconColor)
                .clipShape(Circle())
    }
}
