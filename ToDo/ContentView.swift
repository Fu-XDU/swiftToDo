//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
}

var Items = [
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
    Item(title: "Id:\(1)"),
]

struct ContentView: View {
    @State var dataItems = Items;
    var body: some View {
        NavigationView {
            List {
                ForEach(dataItems) { element in
                    Button(element.title) {

                    }
                }.onDelete(perform: deleteRow)

            }.background(Color.orange)
                    .padding().navigationTitle("计划").background(Color.orange)
        }
    }

    func deleteRow(at offsets: IndexSet) {
        dataItems.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
