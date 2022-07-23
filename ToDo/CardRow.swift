//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct CardRow: View {
    let height: CGFloat = 100
    let spacing: CGFloat = 20
    var body: some View {
        HStack(spacing: spacing) {
            Card()
            Card()
        }
    }
}

struct CardRow_Previews: PreviewProvider {
    static var previews: some View {
        CardRow()
    }
}
