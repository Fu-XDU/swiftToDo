//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct Card: View {
    let height: CGFloat = 100

    var body: some View {
        Rectangle()
                .fill(Color.red)
                .frame(height: height)
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        Card()
    }
}
