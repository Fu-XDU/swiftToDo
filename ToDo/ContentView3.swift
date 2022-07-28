//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct ContentView3: View {
    init() {
    }

    var body: some View {
        CustomNavigationView(view: Home())
                .ignoresSafeArea()
    }
}

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}
