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

var Items = [
    Item(title: "test1", done: false, favorite: true),
    Item(title: "test2", done: false, favorite: true),
    Item(title: "test3", done: false, favorite: false),
    Item(title: "test4", done: false, favorite: false),
    Item(title: "test5", done: false, favorite: false),
]

var Items2 = [
    Item(title: "test6", done: true, favorite: true),
    Item(title: "test7", done: true, favorite: true),
    Item(title: "test8", done: true, favorite: false),
    Item(title: "test9", done: true, favorite: false),
    Item(title: "test10", done: true, favorite: false),
]

var purple = Color(red: 0.44, green: 0.55, blue: 0.89)
var gray = Color(red: 0.58, green: 0.58, blue: 0.58)

struct ContentView: View {
    @State var undoneItems = Items;
    @State var doneItems = Items2;
    @State private var isExpanded = true

    init() {
        //UITableView.appearance().backgroundColor = .black
        UITableView.appearance().sectionFooterHeight = 1
        UITableView.appearance().sectionHeaderHeight = 1
        UIToolbar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
    }

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(undoneItems.indices, id: \.self) { i in
                        Section {
                            HStack(spacing: 20) {
                                Button {
                                    undoneItems[i].changeDone()
                                    itemDone(index: i)
                                } label: {
                                    Image(systemName: undoneItems[i].done ? "checkmark.circle.fill" : "circle")
                                            .scaleEffect(1.5)
                                            .foregroundColor(undoneItems[i].done ? purple : gray)
                                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                }
                                Text("\(undoneItems[i].title)")
                                //.foregroundColor(.white)
                                // 加入Spacer 使右侧图标居右放置
                                Spacer()
                                Button {
                                    undoneItems[i].changeFavorite()
                                } label: {
                                    Image(systemName: undoneItems[i].favorite ? "star.fill" : "star")
                                            .scaleEffect(1.2)
                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                            .foregroundColor(undoneItems[i].favorite ? purple : gray)
                                            .padding(.trailing, 15)
                                }
                            }
                                    .frame(width: 380, height: 50, alignment: .leading)
                                    .padding(.leading, 15)
                        }
                                .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .cornerRadius(5)
                                .padding(.top, -5)
                        //.frame(width: 440)
                    }
                    //.onDelete(perform: deleteRow)


                    DisclosureGroup(isExpanded: $isExpanded) {
                        ForEach(doneItems.indices, id: \.self) { i in
                            Section {
                                HStack(spacing: 20) {
                                    Button {
                                        doneItems[i].changeDone()
                                        itemUndone(index: i)
                                    } label: {
                                        Image(systemName: doneItems[i].done ? "checkmark.circle.fill" : "circle")
                                                .scaleEffect(1.5)
                                                .foregroundColor(doneItems[i].done ? purple : gray)
                                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                    }
                                    Text("\(doneItems[i].title)").strikethrough().foregroundColor(gray)
                                    //.foregroundColor(.white)
                                    // 加入Spacer 使右侧图标居右放置
                                    Spacer()
                                    Button {
                                        doneItems[i].changeFavorite()
                                    } label: {
                                        Image(systemName: doneItems[i].favorite ? "star.fill" : "star")
                                                .scaleEffect(1.2)
                                                .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                                .foregroundColor(doneItems[i].favorite ? purple : gray)
                                                .padding(.trailing, 15)
                                    }
                                }
                                        .frame(width: 380, height: 50, alignment: .leading)
                                        .padding(.leading, 15)
                            }
                                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                    .cornerRadius(5)
                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        }
                                //.onDelete(perform: deleteRow)
                                .frame(height: 45)
                        Spacer()
                    } label: {
                        Button {
                            isExpanded = !isExpanded
                        } label: {
                            HStack {
                                Image(systemName: "chevron.forward")
                                        .scaleEffect(0.8)
                                        .rotationEffect(Angle.init(degrees: isExpanded ? 90 : 0))
                                        .padding(.trailing, -2)
                                Text("已完成")
                            }
                        }
                                .font(.system(size: 15))
                                .frame(width: 80, height: 30)
                                .foregroundColor(purple)
                                .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .cornerRadius(5)
                                .padding(EdgeInsets(top: -5, leading: 10, bottom: 0, trailing: 0))
                    }
                            .buttonStyle(PlainButtonStyle()).accentColor(.clear)//.disabled(true)

                }
            }
                    .navigationTitle("计划").toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "person.badge.plus").font(.system(size: 20)).foregroundColor(purple).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                }
                                Button(action: {}) {

                                    Image(systemName: "ellipsis").font(.system(size: 20)).foregroundColor(purple).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                }
                            }
                        }

                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {}, label: {
                                HStack(spacing: 20) {
                                    Image(systemName: "plus").font(.system(size: 25)).foregroundColor(purple)
                                    Text("添加任务")
                                            .foregroundColor(purple).padding(.leading, -5)
                                }
                                        .frame(width: 380, height: 50, alignment: .leading)
                                        .padding(.leading, 15)
                            })
                                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                    .cornerRadius(10)
                                    .padding(.top, 10)
                        }
                    }
        }
    }

    func itemDone(index: Int) {
        let t = undoneItems[index]
        undoneItems.remove(at: index)
        doneItems.insert(t, at: 0)
    }

    func itemUndone(index: Int) {
        let t = doneItems[index]
        doneItems.remove(at: index)
        undoneItems.insert(t, at: 0)
    }

    func deleteRow(at offsets: IndexSet) {
        undoneItems.remove(atOffsets: offsets)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
