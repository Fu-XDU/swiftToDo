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
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
    Item(title: "ID:\(1)"),
]

struct ContentView: View {
    @State var dataItems = Items;

    init() {
        UITableView.appearance().backgroundColor = .black
        UITableView.appearance().sectionFooterHeight = 1
        UITableView.appearance().sectionHeaderHeight = 1
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(dataItems) { element in
                    Section {
                        HStack {
                            Circle()
                                    .stroke(Color(red: 0.58, green: 0.58, blue: 0.58), style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 22, height: 22).padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 10))
                            Text("Hello World. \(element.title)")
                                    .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "star")
                                    .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                    .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                        }
                    }
                }
                        .onDelete(perform: deleteRow)
                        .listRowBackground(Color(red: 0.13, green: 0.13, blue: 0.13))
                        .frame(height: 40)
            }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle(Text("计划"))
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
