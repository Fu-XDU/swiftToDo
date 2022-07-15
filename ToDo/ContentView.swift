//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI


var purple = Color(red: 0.44, green: 0.55, blue: 0.89)
var gray = Color(red: 0.58, green: 0.58, blue: 0.58)

struct ContentView: View {

    @EnvironmentObject var taskViewModel: TaskViewModel

    @State private var isExpanded = true
    @State private var input = ""
    @State private var showNew = false

    init() {
        //UITableView.appearance().backgroundColor = .black
        UITableView.appearance().sectionFooterHeight = 1
        UITableView.appearance().sectionHeaderHeight = 1
        UIToolbar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.44, green: 0.55, blue: 0.89, alpha: 1)]
    }

    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                        Section {
                            HStack(spacing: 20) {
                                Button {
                                    taskViewModel.undoneItems[i].changeDone()
                                    taskViewModel.itemDone(index: i)
                                } label: {
                                    Image(systemName: taskViewModel.undoneItems[i].done ? "checkmark.circle.fill" : "circle")
                                            .scaleEffect(1.5)
                                            .foregroundColor(taskViewModel.undoneItems[i].done ? purple : gray)
                                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                }
                                Text("\(taskViewModel.undoneItems[i].title)")
                                //.foregroundColor(.white)
                                // 加入Spacer 使右侧图标居右放置
                                Spacer()
                                Button {
                                    taskViewModel.undoneItems[i].changeFavorite()
                                } label: {
                                    Image(systemName: taskViewModel.undoneItems[i].favorite ? "star.fill" : "star")
                                            .scaleEffect(1.2)
                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                            .foregroundColor(taskViewModel.undoneItems[i].favorite ? purple : gray)
                                            .padding(.trailing, 15)
                                }
                            }
                                    .frame(width: 380, height: 50, alignment: .leading)
                                    .padding(.leading, 15)
                        }
                                .background(Color(red: 0.13, green: 0.13, blue: 0.13))
                                .cornerRadius(5)
                                .padding(.top, -5)
                        //.animation(Animation.easeOut(duration: 0.6).delay(100 * Double(i)), value: false)
                        //.transition(.move(edge: .leading))
                        //.frame(width: 440)
                    }
                    //.onDelete(perform: deleteRow)


                    DisclosureGroup(isExpanded: $isExpanded) {
                        ForEach(taskViewModel.doneItems.indices, id: \.self) { i in
                            Section {
                                HStack(spacing: 20) {
                                    Button {
                                        taskViewModel.doneItems[i].changeDone()
                                        taskViewModel.itemUndone(index: i)
                                    } label: {
                                        Image(systemName: taskViewModel.doneItems[i].done ? "checkmark.circle.fill" : "circle")
                                                .scaleEffect(1.5)
                                                .foregroundColor(taskViewModel.doneItems[i].done ? purple : gray)
                                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                    }
                                    Text("\(taskViewModel.doneItems[i].title)").strikethrough().foregroundColor(gray)
                                    //.foregroundColor(.white)
                                    // 加入Spacer 使右侧图标居右放置
                                    Spacer()
                                    Button {
                                        taskViewModel.doneItems[i].changeFavorite()
                                    } label: {
                                        Image(systemName: taskViewModel.doneItems[i].favorite ? "star.fill" : "star")
                                                .scaleEffect(1.2)
                                                .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                                .foregroundColor(taskViewModel.doneItems[i].favorite ? purple : gray)
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
                            .background(
                                    NavigationLink(destination: EditTaskView(), isActive: $showNew) {
                                        EmptyView()
                                    }
                            )
                }
            }

            Button(action: {
                showNew = true
            }, label: {
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
                }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
