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
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
//    Item(title: "ID:\(1)"),
]

var purple = Color(red: 0.44, green: 0.55, blue: 0.89)

struct ContentView: View {
    @State var dataItems = Items;
    @State private var isExpanded = false

    init() {
        //UITableView.appearance().backgroundColor = .black
        UITableView.appearance().sectionFooterHeight = 1
        UITableView.appearance().sectionHeaderHeight = 1
        UIToolbar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
    }

/*
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(dataItems) { element in
                        Section {
                            HStack {
                                Circle()
                                        .stroke(Color(red: 0.58, green: 0.58, blue: 0.58), style: StrokeStyle(lineWidth: 2))
                                        .frame(width: 22, height: 22).padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 10))
                                Text("Hello World. \(element.title)")
                                        //.foregroundColor(.white)
                                // 加入Spacer 使右侧图标局右放置
                                Spacer()
                                Image(systemName: "star")
                                        .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                        .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                            }
                        }
                    }
                            .onDelete(perform: deleteRow)

                            //.listRowBackground(Color(red: 0.13, green: 0.13, blue: 0.13))
                            .frame(height: 45)

                    Text("其他内容")
                    DisclosureGroup() {
                        ForEach(dataItems) { element in
                            Section {
                                HStack {
                                    Circle()
                                            .stroke(Color(red: 0.58, green: 0.58, blue: 0.58), style: StrokeStyle(lineWidth: 2))
                                            .frame(width: 22, height: 22).padding(EdgeInsets(top: 0, leading: -5, bottom: 0, trailing: 10))
                                    Text("Hello World. \(element.title)")
                                            //.foregroundColor(.white)
                                    // 加入Spacer 使右侧图标局右放置
                                    Spacer()
                                    Image(systemName: "star")
                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                            .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -10))
                                }
                            }
                        }
                                .onDelete(perform: deleteRow)
                                .frame(height: 45)
                                //.listRowBackground(Color(red: 0.13, green: 0.13, blue: 0.13))
                    } label: {
                        RoundedRectangle(cornerRadius: 8).frame(width: 150, height: 40)
                    }

                }
                        .listStyle(InsetGroupedListStyle()).frame(width: 440)


            }
                    .navigationTitle(Text("计划")).toolbar {
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
                                        .frame(width: 365, height: 50, alignment: .leading)
                                        .padding(.leading, 15)
                            })
                                    //.background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                    .cornerRadius(10)
                                    .padding(.top, 20)
                        }
                    }

        }
    }
*/

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(0..<10) { i in
                        Section {
                            HStack(spacing: 20) {
                                Circle()
                                        .stroke(Color(red: 0.58, green: 0.58, blue: 0.58), style: StrokeStyle(lineWidth: 2))
                                        .frame(width: 22, height: 22).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                Text("Hello World. \(i)")
                                //.foregroundColor(.white)
                                // 加入Spacer 使右侧图标居右放置
                                Spacer()
                                Image(systemName: "star")
                                        .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                        .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                        .padding(.trailing, 15)
                            }
                                    .frame(width: 380, height: 50, alignment: .leading)
                                    .padding(.leading, 15)
                        }
                                .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .cornerRadius(5)
                                .padding(.top, -5)
                        //.frame(width: 440)
                    }


                    DisclosureGroup(isExpanded: $isExpanded) {
                        ForEach(dataItems) { element in
                            Section {
                                HStack(spacing: 20) {
                                    Circle()
                                            .stroke(Color(red: 0.58, green: 0.58, blue: 0.58), style: StrokeStyle(lineWidth: 2))
                                            .frame(width: 22, height: 22).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                    Text("Hello World. \(element.title)")
                                    //.foregroundColor(.white)
                                    // 加入Spacer 使右侧图标居右放置
                                    Spacer()
                                    Image(systemName: "star")
                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                            .foregroundColor(Color(red: 0.58, green: 0.58, blue: 0.58))
                                            .padding(.trailing, 15)
                                }
                                        .frame(width: 380, height: 50, alignment: .leading)
                                        .padding(.leading, 15)
                            }
                                    .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                    .cornerRadius(5)
                                    .padding(.top, 5)
                        }
                                //.onDelete(perform: deleteRow)
                                .frame(height: 45)
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
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 0))
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
                                    .padding(.top, 20)
                        }
                    }
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
