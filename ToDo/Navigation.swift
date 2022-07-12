//
//  NavigationView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
        NavigationView {
                    Image("100years")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .navigationTitle("Agatha Christie")
        }}
    }


struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
